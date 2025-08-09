# HTKitDemo

This is a demo XCode project for [HTKit](https://github.com/bjnortier/HTKit), showcasing how to use the HTKit library in a SwiftUI application.

The `ggml-tiny.bin` and `jfk.wav` files that are required for the demo are not included in this repository. You can download them from the following links:

- [ggml-tiny.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.bin)
- [jfk.wav](https://files.bjnortier.com/HTKit/jfk.wav)

They should be placed in the `HTKitDemo/Resources` directory.

E.g from the command line:

```
cd HTKitDemo/Resources
wget https://files.bjnortier.com/HTKit/jfk.wav
wget https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.bin
cd -
```
