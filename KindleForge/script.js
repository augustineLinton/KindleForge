var apps = null;

function _fetch(url) {
  var xhr = new XMLHttpRequest();
  xhr.open("GET", url, true);

  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4) {
      if (xhr.status === 200) {
        try {
          apps = JSON.parse(xhr.responseText);
          load(); 
        } catch (e) {
          console.error("Failed To Parse JSON:", e);
        }
      } else {
        console.error("Request Failed With Status; " + xhr.status);
      }
    }
  };

  xhr.send();
}

function load() {
  var icons = {
    book: "<svg class='icon' viewBox='0 0 24 24'>" +
            "<path d='M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z'></path>" +
            "<path d='M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z'></path>" +
          "</svg>",
    download: "<svg class='icon' viewBox='0 0 24 24'>" +
                "<path d='M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4'></path>" +
                "<polyline points='7 10 12 15 17 10'></polyline>" +
                "<line x1='12' y1='15' x2='12' y2='3'></line>" +
              "</svg>"
  };
  
  function card(app) {
    var html = "";
    html += "<article class='card'>";
    html += "  <div class='header'>";
    html += "    <div class='title-box'>";
    html += "      <h2 class='title'>" + app.name + "</h2>";
    html += "      <p class='author'>by " + app.author + "</p>";
    html += "    </div>";
    html += "  </div>";
    html += "  <p class='description'>" + app.description + "</p>";
    html += "  <button class='install-button'>";
    html +=      icons.download;
    html += "    Install Application";
    html += "  </button>";
    html += "</article>";
    return html;
  };

function render() {
    var list = document.getElementById("apps");
    var html = "";
    for (var i = 0; i < apps.length; i++) {
      html += card(apps[i]);
    }
    list.innerHTML = html;

    var install = document.querySelectorAll(".install-button");
    for (var i = 0; i < install.length; i++) {
      (function(index) {
        install[index].addEventListener("click", function() {
          //Trigger Installation Code
          kindle.messaging.sendStringMessage("com.kindlemodding.utild", "runCMD", "kpm -S " + apps[index].kpm);
        });
      })(i);
    }
  };

  render();
};  

document.addEventListener("DOMContentLoaded", function() {
    _fetch("https://raw.githubusercontent.com/polish-penguin-dev/KindleForge/refs/heads/master/registry.json"); //Fetch App Registry
    document.getElementById("status").innerHTML = "JS Working!";
});