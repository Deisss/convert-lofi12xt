This project aims to convert sample in the format for Sonicware - Lofi-12 XT.

Internally, it uses FFMPEG to convert the samples.


# Installation

## Windows

You need first to [download and install](https://www.ffmpeg.org/download.html) FFMPEG.

You need then to have FFMPEG registered into the [windows's path](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/).

Once this is done, you can run the program using the following command:
```bash
.\convert-lofi12xt.bat -i <input_folder> -o <output_folder> -r <sample_rate>
```

Where:
  - **input_folder** is the folder where original samples are
  - **output_folder** is the output folder (will be created if not existing)
  - **sample_rate** optional parameter, the sample rate, in Hz, so the default value is `24000`

It's not recommended to have the same input and output folder.


## MacOS

You need first to [download and install](https://www.ffmpeg.org/download.html) FFMPEG. The easy way would likely be [homebrew](https://formulae.brew.sh/formula/ffmpeg).

It needs to be added to the path, usually homebrew help on this.

Once done, you need to make the script executable:
```bash
chmod +x convert-lofi12xt.sh
```

Once this is done, you can run the program using the following command:
```bash
./convert-lofi12xt.sh -i <input_folder> -o <output_folder> -r <sample_rate>
```