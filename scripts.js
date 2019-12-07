var userSong = undefined;

function addSongElement(songstr) {
    var here = document.getElementById("playlist").childNodes.length;
    console.log(here)
    // create a new div element 
    var newSongDiv = document.createElement("div");
    newSongDiv.id = here + "song";
    // add in a text area to display the song information 
    var textArea = document.createElement("textarea");
    textArea.cols = 75;
    textArea.readOnly = true;
    textArea.innerHTML = songstr;
    textArea.style = "padding: 2px 5px;resize: none;float: left;font-style: Book Antiqua; font-size: 16px;"

    var trashBtn = document.createElement("BUTTON");
    trashBtn.id = "trash";
    trashBtn.innerHTML = '<i class="fa fa-trash"></i>';
    trashBtn.style = "background-color: DodgerBlue;border: none;color: white;padding: 12px 16px;font-size: 16px;cursor: pointer;";

    trashBtn.onclick = removeSong.bind("onclick", newSongDiv.id);
    // add the text area to the newly created div
    newSongDiv.appendChild(textArea);
    newSongDiv.appendChild(trashBtn);

    newSongDiv.style = "padding: .2%;"
    // add the newly created element and its content into the DOM 
    var currentDiv = document.getElementById("song");
    document.getElementById("playlist").insertBefore(newSongDiv, currentDiv);
}

function addAndRemove(songstr) {
    addSongElement(songstr);
    $.ajax({
        url:'/getSongInfo',
        data: {searchField: userSong},
        type: 'POST',
        success: function(response) {
            console.log(response);
        },
        error: function(error) {
            console.log(error);
        }
    });
    removeSearchBox();
}
String.prototype.replaceAt = function (index, replacement) {
    return this.substr(0, index) + replacement + this.substr(index + replacement.length);
}

function fetchItunesInfo() {
    var searchTerm = document.getElementById("searchField").value;
    userSong = searchTerm
    document.getElementById("searchField").value = "";
    for (i = 0; i < String(searchTerm).length; i++) {
        if (String(searchTerm).indexOf(" ") == i) {
            searchTerm = String(searchTerm).replaceAt(i, "+");
        }
    }
    searchTerm = searchTerm + "&limit=1";
    var url = "https://itunes.apple.com/search?term=" + searchTerm;
    var returnStr = "";
    const http = new XMLHttpRequest();
    http.open("GET", url, true);

    http.onload = () => {
        console.log(http.responseText)
        console.log(JSON.parse(http.responseText));
        var myJSON = JSON.parse(http.responseText);
        console.log(myJSON.results[0].trackName);
        songName = myJSON.results[0].trackName;
        artistName = myJSON.results[0].artistName;
        songTime = msToTime(myJSON.results[0].trackTimeMillis);
        returnStr = "song: " + myJSON.results[0].trackName + ", Artist name: " + myJSON.results[0].artistName + ", length: " + msToTime(myJSON.results[0].trackTimeMillis);

        addSearchBox(returnStr);
    };

    http.send();
}

function msToTime(duration) {
    var milliseconds = parseInt((duration % 1000) / 100),
        seconds = Math.floor((duration / 1000) % 60),
        minutes = Math.floor((duration / (1000 * 60)) % 60),
        hours = Math.floor((duration / (1000 * 60 * 60)) % 24);

    hours = (hours < 10) ? "0" + hours : hours;
    minutes = (minutes < 10) ? "0" + minutes : minutes;
    seconds = (seconds < 10) ? "0" + seconds : seconds;

    return hours + ":" + minutes + ":" + seconds + "." + milliseconds;
}

function removeSearchBox() {
    var searchResultRemove = document.getElementById("sresults");
    if (searchResultRemove != null) {
        searchResultRemove.remove();
    }
}
function removeSong(childNode) {
    if (document.getElementById(childNode) != null) {
        $.ajax({
        url:'/deleteSong',
        data: {deletedSong: document.getElementById(childNode).childNodes[0].innerHTML},
        type: 'POST',
        success: function(response) {
            console.log(response);
        },
        error: function(error) {
            console.log(error);
        }
    });
        document.getElementById("playlist").removeChild(document.getElementById(childNode));
    }
}

function addSearchBox(songStr) {
    this.removeSearchBox();
    var searchArea = document.createElement("div");
    searchArea.id = "sresults";

    var userInput = songStr;

    var searchAreaResults = document.createTextNode(userInput);
    var confirmBtn = document.createElement("BUTTON");
    confirmBtn.innerText = "confirm add";
    confirmBtn.onclick = addAndRemove.bind("onclick", userInput);
    var dontAdd = document.createElement("button");
    dontAdd.innerText = "do not add";
    dontAdd.onclick = removeSearchBox;
    confirmBtn.style = "position: absolute; bottom: 0px;left: 0px;"
    dontAdd.style = "position: absolute; bottom: 0px; left: 95px;"
    searchAreaResults.style = "padding: 2%;float: left;";
    searchArea.style = "position: relative; width: 100%; height: 50px; background-color: powderblue;";
    searchArea.appendChild(confirmBtn);
    searchArea.appendChild(dontAdd);
    searchArea.insertBefore(searchAreaResults, confirmBtn);

    document.body.insertBefore(searchArea, document.getElementById("playlist"));
}