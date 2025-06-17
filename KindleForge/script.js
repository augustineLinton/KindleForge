/*
  KindleForge
  "Do not ask me what is here, for I have no idea" -penguins184

  06/2025
*/

var apps = null;
var lock = false;

function _fetch(url, cb) {
  var xhr = new XMLHttpRequest();
  xhr.open("GET", url, true);
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
      if (typeof cb === "function") {
        cb(xhr.responseText);
      } else {
        try {
          apps = JSON.parse(xhr.responseText);
          init();
        } catch (e) {}
      }
    }
  };
  xhr.send();
}

function _file(url) {
  return new Promise(function (resolve) {
    var iframe = document.createElement("iframe");
    iframe.src = url;
    document.body.appendChild(iframe);
    iframe.addEventListener("load", function (e) {
      var src = e.target.contentDocument.documentElement.innerHTML;
      e.target.remove();
      resolve(
        src
          .replace(
            '<head></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">',
            ""
          )
          .replace("</pre></body>", "")
          .replace("<head></head><body></body>", "")
      );
    });
    setTimeout(function () {
      iframe.remove();
    }, 2000);
  });
}

function init() {
  _file("file:///var/local/mesquite/KindleForge/assets/packages.list").then(
    function (data) {
      var installed = data.split(/\r?\n/).filter(function (ln) {
        return ln.trim() !== "";
      });
      render(installed);
    }
  );
}

function render(installed) {
  var icons = {
    download:
      "<svg class='icon' viewBox='0 0 24 24'>" +
      "<path d='M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4'></path>" +
      "<polyline points='7 10 12 15 17 10'></polyline>" +
      "<line x1='12' y1='15' x2='12' y2='3'></line>" +
      "</svg>",
    progress:
      "<svg class='icon' viewBox='0 0 24 24'>" +
      "<path d='M3 12a9 9 0 0 1 9-9 9.75 9.75 0 0 1 6.74 2.74L21 8'></path>" +
      "<path d='M21 3v5h-5'></path>" +
      "<path d='M21 12a9 9 0 0 1-9 9 9.75 9.75 0 0 1-6.74-2.74L3 16'></path>" +
      "<path d='M3 21v-5h5'></path>" +
      "</svg>",
    x:
      "<svg class='icon' viewBox='0 0 24 24'>" +
      "<line x1='18' y1='6' x2='6' y2='18'></line>" +
      "<line x1='6' y1='6' x2='18' y2='18'></line>" +
      "</svg>"
  };

  var container = document.getElementById("apps");
  while (container.firstChild) container.removeChild(container.firstChild);

  function makeButton(name, isInst) {
    var btn = document.createElement("button");
    btn.className = "install-button";
    btn.setAttribute("data-name", name);
    btn.setAttribute("data-installed", isInst ? "true" : "false");
    btn.innerHTML =
      (isInst ? icons.x : icons.download) +
      (isInst ? " Uninstall Application" : " Install Application");
    return btn;
  }

  // Helper to fetch download count for a package
  function fetchDownloadCount(pkgName, cb) {
    _fetch(
      "https://kindleforge.gingr.workers.dev/count?name=" + encodeURIComponent(pkgName),
      function (resp) {
        try {
          var data = JSON.parse(resp);
          cb(data.count || 0);
        } catch (e) {
          cb(0);
        }
      }
    );
  }

  for (var i = 0; i < apps.length; i++) {
    var app = apps[i];
    var isInst = installed.indexOf(app.name) !== -1;

    var card = document.createElement("article");
    card.className = "card";

    var header = document.createElement("div");
    header.className = "header";
    var titleBox = document.createElement("div");
    titleBox.className = "title-box";

    var h2 = document.createElement("h2");
    h2.className = "title";
    h2.textContent = app.name;

    var pAuth = document.createElement("p");
    pAuth.className = "author";
    pAuth.textContent = "by " + app.author;

    titleBox.appendChild(h2);
    titleBox.appendChild(pAuth);
    header.appendChild(titleBox);

    var pDesc = document.createElement("p");
    pDesc.className = "description";
    pDesc.textContent = app.description;

    // Download count element
    var pCount = document.createElement("p");
    pCount.className = "download-count";
    pCount.textContent = "Downloads: ...";
    card.appendChild(pCount);
    // Fetch and update count
    fetchDownloadCount(app.name, function(count) {
      pCount.textContent = "Downloads: " + count;
    });

    var btn = makeButton(app.name, isInst);

    card.appendChild(header);
    card.appendChild(pDesc);
    card.appendChild(btn);
    container.appendChild(card);
  }

  var buttons = container.querySelectorAll(".install-button");
  for (var j = 0; j < buttons.length; j++) {
    (function (idx) {
      buttons[idx].addEventListener("click", function () {
        var btn = this;
        var name = btn.getAttribute("data-name");
        var wasInst = btn.getAttribute("data-installed") === "true";

        btn.disabled = true;

        if (lock) {
          btn.innerHTML =
            icons.x +
            (wasInst
              ? " Another Uninstall In Progress!"
              : " Another Download In Progress!");
          setTimeout(function () {
            btn.disabled = false;
            btn.innerHTML =
              (wasInst ? icons.x : icons.download) +
              (wasInst
                ? " Uninstall Application"
                : " Install Application");
          }, 3000);
          return;
        }
        lock = true;

        var action = wasInst ? "uninstall" : "install";
        var scriptUrl =
          "https://raw.githubusercontent.com/polish-penguin-dev/KindleForge/refs/heads/master/Registry/" +
          name +
          "/" +
          action +
          ".sh";

        btn.innerHTML =
          icons.progress +
          (wasInst ? " Uninstalling " : " Installing ") +
          name +
          "...";

        (window.kindle || top.kindle).messaging.sendStringMessage(
          "com.kindlemodding.utild",
          "runCMD",
          "curl " + scriptUrl + " | sh"
        );

        var start = Date.now();
        var pollId = setInterval(function () {
          if (Date.now() - start >= 30000) {
            clearInterval(pollId);
            lock = false;
            btn.disabled = false;
            btn.innerHTML =
              icons.x +
              (wasInst
                ? " Failed to Uninstall "
                : " Failed to Install ") +
              name +
              "!";
            setTimeout(function () {
              window.location.reload();
            }, 5000);
            return;
          }
          _file(
            "file:///var/local/mesquite/KindleForge/assets/packages.list"
          ).then(function (data) {
            var present = data.indexOf(name) !== -1;
            if ((!wasInst && present) || (wasInst && !present)) {
              clearInterval(pollId);
              lock = false;
              window.location.reload();
            }
          });
        }, 500);
      });
    })(j);
  }
}

document.addEventListener("DOMContentLoaded", function () {
  _fetch(
    "https://raw.githubusercontent.com/polish-penguin-dev/KindleForge/refs/heads/master/Registry/registry.json"
  );
  document.getElementById("status").innerText = "JS Working!";
});
