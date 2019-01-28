# Raw to MP3

Convert your *wav* files into *mp3* files on different platforms.

This is inspired by [lazka/mutagen-mp3-test-vector][lazka],
which is a *mp3* converter on *Windows*.

## How to run

1. Put your *wav* files under *sources*.
2. Run `$ bash encode.sh` or `$ sh encode.sh`
3. The output *mp3* files will be put under a created *mp3* folder.

## MP3 Encoders
The files are encoded by [*Fraunhofer encoder*][fhg] and [*FFmpeg* with *libmp3lame* library][ffmpeg-libmp3lame]. If there is no *ffmpeg* on the platform, no *mp3* files with *Xing* headers will be generated. However, *mp3* files with *VBRI* headers or wihtout any headers will be generated on the supported platforms.

The header types of the converted *mp3* by different encoders are:
- [*Fraunhofer encoder*][fhg]
    - *CBR*: No header
    - *VBR*: No header, or with *VBRI* tag within *VBRI* header
- [*FFmpeg* with *libmp3lame* library][ffmpeg-libmp3lame]
    - *CBR*: *Info* tag within *Xing* header
    - *VBR*: *Xing* tag within *Xing* header

## TODO
- [x] Make it run on Linux
- [x] Make it run on Windows
- [ ] Add [*LAME* mp3 encoder][lame] to work on platforms without *ffmpeg*
- [x] Encode by *ffmpeg* if it's installed on the platform
- [ ] Add a brief intro for mp3 format
    - Header types
        - No header: *CBR* (constant bit rate) or *VBR* (variable bit rate)
        - *Xing*: two different tags
            - *Xing*: *VBR* (variable bit rate)
            - *Info*: *CBR* (constant bit rate)
        - *VBRI* (tag is *VBRI*): *VBR* (variable bit rate)
- [ ] Support more raw file format like *aiff*(*.aif*) file

## References
- [lazka/mutagen-mp3-test-vector][lazka]
- [FhG MP3 Surround][fhg]
- [FFmpeg MP3 Encoding Guide][ffmpeg-libmp3lame]

[lazka]: https://github.com/lazka/mutagen-mp3-test-vector "lazka/mutagen-mp3-test-vector"
[fhg]: http://www.rarewares.org/rrw/fhgmp3s.php "FhG MP3 Surround"
[lame]: http://lame.sourceforge.net/ "LAME MP3 Encoder"
[ffmpeg]: https://www.ffmpeg.org/ "FFmpeg"
[ffmpeg-libmp3lame]: https://trac.ffmpeg.org/wiki/Encode/MP3 "FFmpeg MP3 Encoding Guide"
