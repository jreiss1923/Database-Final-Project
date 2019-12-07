import requests
import mysql.connector
from flask import Flask, jsonify, render_template, request
import sys
#response = requests.get('https://itunes.apple.com/search?term=Hiroyuki+Sawano&limit=1')
#print(response.json())

mydb = mysql.connector.connect(
    host="localhost",
    user="database username here",
    passwd="database password here",
    database="itunes2"
)
mycursor = mydb.cursor()

app = Flask(__name__)

@app.route("/")
def hello():
    return render_template('index.html')

@app.route('/loadDatabase', methods=['POST', 'GET'])
def loadDb():
    mycursor.execute("select * from song")
    song_data = mycursor.fetchall()
    return render_template('index.html', databaseentries=song_data)


@app.route('/renamePlaylist', methods=['POST'])
def renamePl():
    s = request.form.get("playlistRename")
    mycursor.execute("update playlist set playlistName = '%s' where playlistId = 1" % s)
    mydb.commit()
    return ('', 204)


@app.route('/deleteSong', methods=['POST'])
def deleteSongFromDatabase():
    song_name = request.form['deletedSong']
    song_name = song_name[6:]
    song_name = song_name.split(",")[0]
    x = []
    x.append(song_name)
    mycursor.callproc("deleteSong", x)
    mydb.commit()
    return "hello"

@app.route('/getSongInfo', methods=['POST'])
def addSongToDatabase():
    song_name = request.form['searchField']
    response = requests.get('https://itunes.apple.com/search?term=' + song_name + '&limit=1').json()

    track_id = str(response['results'][0]['trackId'])

    track_name = str(response['results'][0]['trackName'])

    artist_id = response['results'][0]['artistId']
    artist_response = requests.get('https://itunes.apple.com/lookup?id=' + str(artist_id)).json()
    artist_name = artist_response['results'][0]['artistName']
    record_tuple = (str(artist_id), artist_name)

    mycursor.execute("select artist_id from artist")
    artist_names_in_db = mycursor.fetchall()

    x = []
    for row in artist_names_in_db:
        x.append(int(row[0]))

    if(artist_id not in x):
        mycursor.execute("insert into artist (artist_id, artist_name) values (%s, %s)", record_tuple)


    collection_id = response['results'][0]['collectionId']
    album_response = requests.get('https://itunes.apple.com/lookup?id=' + str(collection_id)).json()
    album_name = album_response['results'][0]['collectionName']
    record_tuple = (str(collection_id), album_name)

    mycursor.execute("select album_id from album")
    album_names_in_db = mycursor.fetchall()

    x = []
    for row in album_names_in_db:
        x.append(int(row[0]))

    if collection_id not in x:
        mycursor.execute("insert into album (album_id, album_name) values (%s, %s)", record_tuple)

    genre = response['results'][0]['primaryGenreName']

    total_time_in_seconds = response['results'][0]['trackTimeMillis']//1000
    time_in_minutes = total_time_in_seconds//60
    time_in_seconds = total_time_in_seconds % 60
    time_formatted = time_in_minutes * 100 + time_in_seconds
    time_formatted = str(time_formatted)

    record_tuple = (track_id, track_name, collection_id, artist_id, time_formatted, genre, "1")
    mycursor.execute("insert into song (song_id, song_name, album_id, artist_id, song_length, genre_name, playlist_id) values (%s, %s, %s, %s, %s, %s, %s)", record_tuple)
    mydb.commit()

    return "committed song information to database"



if __name__ == "__main__":
    app.run()

def main():
    app.run()




