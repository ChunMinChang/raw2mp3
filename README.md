# Raw to MP3

Convert your *wav* files into *mp3* files on different platforms.

This is inspired by [lazka/mutagen-mp3-test-vector][lazka],
which is a *mp3* converter on *Windows*.

## How to run

1. Put your *wav* files under *sources*.
2. Run `$ sh encode.sh`
3. The output *mp3* files will be put under a created *mp3* folder.

## MP3 Encoder
Currently the files are encoded only by [*Fraunhofer encoder*][fhg],
which can convert *wav* files into *mp3* files with *VBRI* headers
or without any headers.

## TODO
- [ ] Make it run on Linux
- [ ] Make it run on Windows
- [ ] Add [*LAME* mp3 encoder][lame]
- [ ] Encode by *ffmpeg* if it's installed on the platform
- [ ] Add a brief intro for mp3 format
    - Header types
        - No header: *CBR* (constant bit rate) or *VBR* (variable bit rate)
        - *Xing*: two different tags
            - *Xing*: *VBR* (variable bit rate)
            - *Info*: *CBR* (constant bit rate)
        - *VBRI* (tag is *VBRI*): *VBR* (variable bit rate)
- [ ] Add info for generated *mp3* with different formats by different encoders
    - *Fraunhofer*
        - *CBR*: No header
        - *VBR*: No header
        - *VBR* with *VBRI* header: *VBRI* tag within *VBRI* header
- [ ] Support more raw file format like *aiff*(*.aif*) file

## References
- [lazka/mutagen-mp3-test-vector][lazka]
- [FhG MP3 Surround][fhg]

[lazka]: https://github.com/lazka/mutagen-mp3-test-vector "lazka/mutagen-mp3-test-vector"
[fhg]: http://www.rarewares.org/rrw/fhgmp3s.php "FhG MP3 Surround"
[lame]: http://lame.sourceforge.net/ "LAME MP3 Encoder"