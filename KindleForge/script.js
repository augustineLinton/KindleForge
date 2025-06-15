var apps = null;
var lock = false;

function _fetch(url) {
  var xhr = new XMLHttpRequest();
  xhr.open("GET", url, true);
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
      try {
        apps = JSON.parse(xhr.responseText);
        init();
      } catch (e) {}
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
      var installed = data.split(/\r?\n/);
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

  function buttonHtml(name, isInstalled) {
    var icon = isInstalled ? icons.x : icons.download;
    var text = isInstalled ? "Uninstall" : "Install";
    return (
      "<button class='install-button' " +
      "data-name='" +
      name +
      "' " +
      "data-installed='" +
      (isInstalled ? "true" : "false") +
      "'>" +
      icon +
      text +
      "</button>"
    );
  }

  var container = document.getElementById("apps"),
    html = "",
    i,
    app,
    isInstalled;

  for (i = 0; i < apps.length; i++) {
    app = apps[i];
    isInstalled = installed.indexOf(app.name) !== -1;
    html +=
      "<article class='card'>" +
      "<div class='header'>" +
      "<div class='title-box'>" +
      "<h2 class='title'>" +
      app.name +
      "</h2>" +
      "<p class='author'>by " +
      app.author +
      "</p>" +
      "</div>" +
      "</div>" +
      "<p class='description'>" +
      app.description +
      "</p>" +
      buttonHtml(app.name, isInstalled) +
      "</article>";
  }

  container.innerHTML = html;

  var buttons = container.querySelectorAll(".install-button"),
    j;

  for (j = 0; j < buttons.length; j++) {
    (function (idx) {
      buttons[idx].addEventListener("click", function () {
        var btn = this;
        var name = btn.getAttribute("data-name");
        var installedFlag = btn.getAttribute("data-installed") === "true";

        if (lock) {
          btn.innerHTML =
            icons.x +
            (installedFlag
              ? "Another Uninstall In Progress!"
              : "Another Download In Progress!");
          setTimeout(function () {
            btn.innerHTML =
              (installedFlag ? icons.x : icons.download) +
              (installedFlag ? "Uninstall" : "Install");
          }, 3000);
          return;
        }
        lock = true;

        var cmd = installedFlag ? "uninstall" : "install";
        var script =
          "https://raw.githubusercontent.com/polish-penguin-dev/KindleForge/refs/heads/master/Registry/" +
          name +
          "/" +
          cmd +
          ".sh";

        btn.innerHTML =
          icons.progress +
          (installedFlag ? "Uninstalling " : "Installing ") +
          name +
          "...";

        (window.kindle || top.kindle).messaging.sendStringMessage(
          "com.kindlemodding.utild",
          "runCMD",
          "curl " + script + " | sh"
        );

        var start = Date.now(),
          pollId = setInterval(function () {
            if (Date.now() - start >= 30000) {
              clearInterval(pollId);
              lock = false;
              btn.innerHTML =
                icons.x +
                (installedFlag ? "Failed to Uninstall " : "Failed to Install ") +
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
              if ((!installedFlag && present) || (installedFlag && !present)) {
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
