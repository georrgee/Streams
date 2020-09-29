//  ContentView.swift
//  Streams
//  Created by George Garcia on 9/29/20.


import SwiftUI

struct Album: Hashable { // Hashable = it will break the id which is /.self
    var id  =  UUID()
    var name:  String
    var image: String
    var songs: [Song] // array of songs
}

struct Song: Hashable {
    var id  = UUID()
    var name: String
    var time: String
}

struct ContentView: View {
    
    var albums = [Album(name: "Rolling Papers", image: "rolling-papers",
                        songs: [Song(name: "The Race", time: "5:36"),
                                Song(name: "On My Level", time: "4:32"),
                                Song(name: "Wake Up", time: "3:47"),
                                Song(name: "Rooftops", time: "4:20")]),
    
                   Album(name: "Silent Alarm", image: "silent-alarm",
                          songs: [Song(name: "Helicopter", time: "3:40"),
                                  Song(name: "Banquet", time: "3:21"),
                                  Song(name: "Luno", time: "3:56")]),
                   Album(name: "K.I.D.S", image: "kids",
                         songs: [Song(name: "Nikes on My Feet", time: "2:45"),
                                 Song(name: "Knock Knock", time: "3:18"),
                                 Song(name: "Senior Skip Day", time: "2:56"),
                                 Song(name: "The Spins", time: "3:16")]),
                   Album(name: "Demon Days", image: "demon-days",
                         songs: [Song(name: "Feel Good Inc.", time: "3:43"),
                                 Song(name: "Dirty Harry", time: "3:51"),
                                 Song(name: "O Green World", time: "4:35"),
                                 Song(name: "El Mañana", time: "3:57")])]
    
    @State private var currentAlbum: Album?
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    LazyHStack {
                        ForEach(self.albums, id: \.self, content: {
                            album in
                            AlbumArt(album: album).onTapGesture{
                                self.currentAlbum = album
                            }
                        })
                    }
                })
                LazyVStack {
                    ForEach((self.currentAlbum?.songs ?? self.albums.first?.songs) ?? [Song(name: "Feel Good Inc.", time: "3:43"),
                                                                                       Song(name: "Dirty Harry", time: "3:51"),
                                                                                       Song(name: "O Green World", time: "4:35"),
                                                                                       Song(name: "El Mañana", time: "3:57")], id: \.self, content: {
                        song in
                        SongCell(song: song)
                    })
                }
            }.navigationTitle("Streams")
        }
    }
}

struct AlbumArt: View {
    var album: Album
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Image(album.image).resizable().aspectRatio(contentMode: .fill).frame(width: 170, height: 200, alignment: .center)
                ZStack {
                    Blur(style: .dark)
                    Text(album.name).foregroundColor(.white)
                }.frame(height: 70, alignment: .center)
            }).frame(width: 170, height: 200, alignment: .center).clipped().cornerRadius(20).shadow(radius: 10).padding(20)
    }
}

struct SongCell: View {
    var song: Song
    var body: some View {
        HStack {
            ZStack {
                Circle().frame(width: 50, height: 50, alignment: .center).foregroundColor(.blue)
                Circle().frame(width: 20, height: 20, alignment: .center).foregroundColor(.white)
            }
            Text(song.name).bold()
            Spacer()
            Text(song.time)
        }.padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SongCell(song: Song(name: "Social Media Man", time: "10:00"))
    }
}
