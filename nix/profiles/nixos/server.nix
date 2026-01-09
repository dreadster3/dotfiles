{ ... }:
{
  imports = [ ./common.nix ];

  modules.nixos = {
    fail2ban.enable = true;
  };

  users.users.dreadster.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCE4y4iP00784oPIFjy8Ad+eWIRW1QPW74jXA/jQVltU8AI8XRKGCUduK8TLopbqZplKfZVgiKqOuMvvYhkQzvS4D1qawPrdamQ+bvTnI4ehZAU7K3lzKTWm2AABytiv9Xm1hF4/wqD/iPxz18rj+mHeoEjcAsNDT/7mPR3EAS0yOg784jfgmKVLyZZGZIcTgaW+SrVkJ68KKA2xlWNTHbALw0NuR1liMDPnEmOXJ0caplBZPH2rbABnR5A7q35FyJbt/3kzjT8T7LXUX51X40/4E20JS8fFvbEZq6EfFmgs8+HsGm3ZH/u6umNt9w3StHCc3c/i0IUodd2tpRjEeD root@pve30"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGCMowytry00kaNo1EMXPhZb0WiEANL9AD1oj9V0f0Ad dreadster@nixos-desktop"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChccKxnuY4n8xiAUYxxaukvxt+2Rucndm6nZy9Q1uuxJRGXac+b6Y0lrKceUX8CyWU5R+gesRggSB0PbEYbCCLee20kcoc0OYFFrwe6w1TrCqIdsdj4qw6/7Yc6SmUgjUlCuD7N0/+KVViL7zYKgljstBiwsn04YzXa3EuGuwvhDCDYtMLKr9uFVPSN6KWku57wa6Vvkk+iDCf/KfcVl/kV0GL6mV3XfcuHSVlZamt4KEx//vI67HvWUo2w3egDTwcDPbed+R8Xy+os3k4Lw/HnVKm1Uyoq8K3c1kSEHDGlaeEuv8SU28K40sUgRPtv+EUcm7R47eCKIAn4FlvVbtVR0swbzyUQ4pCbfCcAwSwXwDQoISLPHQt6CujaLHmdaqEO2vdQJTwi9PPsjt9yKgeXc/IsszJ+g/UM9M1IkCkvT6J5HVUlHSVRNYCGUfEtLa1dxXDC0ngcQ/WFhjjaAgAj9mc3nc11vTfhVshbFPehIfLYk37wHATivCU67YcgoM= dreadster@devbox"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEOHdEL6KgG0RGY98K20I2WCfGKszosd/SZxdkG7jUJE dreadster@nixwsl"
  ];

  security.sudo.wheelNeedsPassword = false;
}
