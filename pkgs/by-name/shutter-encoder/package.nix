{ pkgs, fetchurl }:
pkgs.appimageTools.wrapType2 {
  pname = "shutter-encoder";
  version = "18.0";

  src = fetchurl {
    url = "https://www.shutterencoder.com/sdc_download/497/?key=lfpx4wqaghm4zgswrp015tljfm75ek";
    sha256 = "sha256-mUXSY9186j9zeI4lOzfEJK2Phw+r6H7vjIkcZQGqph4=";
  };

  extraPkgs =
    pkgs: with pkgs; [
      ffmpeg
      mediainfo
      dvdauthor
      yt-dlp
      exiftool
      p7zip
      realesrgan-ncnn-vulkan
      alsa-lib
      gtk3
      glib
    ];
}
