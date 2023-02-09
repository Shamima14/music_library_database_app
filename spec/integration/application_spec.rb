require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET/albums/:id' do
    it 'should return info about album with id 2' do 
      response = get('/albums/2')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end
  end
  context 'GET/albums' do
    it 'lists all albums' do
      response = get('/albums')

      expect(response.status).to eq 200
      expect(response.body).to include ('<a href="/albums/2">Surfer Rosa</a><br />')
      expect(response.body).to include ('<a href="/albums/3">Waterloo</a><br />')
      expect(response.body).to include ('<a href="/albums/4">Super Trouper</a><br />')
      expect(response.body).to include ('<a href="/albums/5">Bossanova</a><br />')
      expect(response.body).to include ('<a href="/albums/6">Lover</a><br />')
      expect(response.body).to include ('<a href="/albums/7">Folklore</a><br />')
      expect(response.body).to include ('<a href="/albums/8">I Put a Spell on You</a><br />')
      expect(response.body).to include ('<a href="/albums/9">Baltimore</a><br />')
      expect(response.body).to include ('<a href="/albums/10">Here Comes the Sun</a><br />')
      expect(response.body).to include ('<a href="/albums/11">Fodder on My Wings</a><br />')
      expect(response.body).to include ('<a href="/albums/12">Ring Ring</a><br />') 
    end
  end
  context 'GET/albums/new' do
    it 'returns a html form with a new album' do
      response = get('/albums/new')

      expect(response.status).to eq 200
      expect(response.body).to include ('<form method="POST" action="/albums">')
      expect(response.body).to include ('<input type="text" name="title" />')
      expect(response.body).to include ('<input type="text" name="release_year" />')
      expect(response.body).to include ('<input type="text" name="artist_id" />')
    end
  end
  context 'POST/albums' do
    it 'creates a new album' do
      response = post('/albums', title: 'Voyage', release_year: 2022, artist_id: 2)

      expect(response.status).to eq 200
      expect(response.body).to eq (' ')

      response = get('/albums')
      expect(response.body).to include('Voyage')
    end
  end
  context 'GET/artists' do
    it 'returns a list of all artists' do
      response = get('/artists')

      expect(response.status).to eq 200
      expect(response.body).to include('<a href="/artists/1">Pixies</a><br />')
      expect(response.body).to include('<a href="/artists/2">ABBA</a><br />') 
      expect(response.body).to include('<a href="/artists/3">Taylor Swift</a><br />') 
      expect(response.body).to include('<a href="/artists/4">Nina Simone</a><br />')   
    end
  end
  context 'GET/artists/new' do
    it 'returns a html form with a new artist' do
      response = get('/artists/new')

      expect(response.status).to eq 200
      expect(response.body).to include ('<form method="POST" action="/artists">')
      expect(response.body).to include ('<input type="text" name="name" />')
      expect(response.body).to include ('<input type="text" name="genre" />')
    end
  end
  context 'GET/artists/:id' do
    it 'should return info about artist with id 1' do 
      response = get('/artists/1')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('Genre: Rock')
    end
  end
  context 'POST/artists' do 
    it 'creates a new artist' do
      response = post('/artists', name: 'Wild nothing', genre: 'Indie')

      expect(response.status).to eq 200
      expect(response.body).to eq ' '

      response = get('/artists')
      expect(response.body).to include 'Wild nothing'
    end
  end
end
