{ ... }:
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    verbose = true;
    backupFileExtension = "hm.old";
  };
}
