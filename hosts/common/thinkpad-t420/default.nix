{
  config,
  inputs,
  ...
}:

{
  imports = [
    # "${inputs.nixos-hardware}/lenovo/thinkpad/t420"
    "${inputs.nixos-hardware}/common/pc/ssd"
  ];
  hardware.bluetooth.enable = true;

  # setup backlight ownership and permissions to video group
  services = {
    xserver.synaptics.enable = false;
  };

}
