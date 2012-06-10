xml.playlist(:version => "1") do
  xml.trackList do
    @tracks.each do |track|
      track = track.becomes(Media)
      xml.track do
        xml.title track.name
        xml.creator
        xml.location track.file.url
      end
    end
  end
end