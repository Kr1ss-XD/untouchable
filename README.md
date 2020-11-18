# Untouchable

###### _Install initcpio hooks to create readonly snapshots during early boot and mount an overlayfs on top._

</br>

---

#### Requirements

Currently, the supported system configuration is :

- [Arch Linux](https://www.archlinux.org)
- [mkinitcpio](https://projects.archlinux.org/mkinitcpio.git)
- [Btrfs](https://btrfs.wiki.kernel.org/index.php/Main_Page) as the root filesystem
- [GRUB](https://www.gnu.org/software/grub/index.html) as the boootloader

I'd be more than happy though to accept contributions which adapt the project to additional distros or initrd frameworks (e.g. [dracut](https://dracut.wiki.kernel.org/index.php/Main_Page)).


</br>

---

#### Rationale

The intention of this project is to enable users to boot and run their system in a way that the actual file system is write-protected, hence to use their everyday OS like an immutable live environment.

Some possible use cases :

- testing packages without risking to damage the actual system
- analyzing malware, e.g. viruses or proprietary applications
- trying out new/untested configurations before deploying them to the system


</br>

---

#### How is this achieved ?

An initcpio hook will be installed onto your system, which will insert a script into your initial RAM-disk. This script is executed at early boot time and will create a write protected snapshot of the subvolume that would be mounted at the filesystem root (`/`), mount that snapshot instead and create a writeable RAM overlay, so that you can work with the system like normal, with the difference that each and every change made during runtime won't affect your permanent filesystem but will be discarded on shutdown/reboot.

Besides this, `untouchable` installs a new `mkinitcpio` preset for each installed kernel which includes this hook, so that an additional `initramfs-linux[-xyz]-untouchable.img` will be created, besides your default `initramfs-linux[-xyz]{,-fallback}.img` ones.

Eventually, after the initcpio-hook and -preset(s) have been installed onto the system and the additional initrd's have been built, the GRUB configuration will be updated to add entries to the boot menu, enabling the user to choose to boot into the "untouchable" system.

</br>

---

#### Credits

A big **THANK YOU** to :

- @Antynea for [grub-btrfs](https://github.com/antynea/grub-btrfs), and especially for [implementing](https://github.com/Antynea/grub-btrfs/commit/9adce629f7632b9ae63ef5bf8e54ea9a9e6eee11) the `grub-btrfs-overlayfs` hook which heavily inspired this very project (see the preceding [discussion](https://github.com/Antynea/grub-btrfs/issues/92) if you're intersted),
- @maximbaz for [packaging](https://www.archlinux.org/packages/community/any/grub-btrfs/) `grub-btrfs` and including it in the Archlinux `[community]` repository,
- all [contributors](https://github.com/archlinux/mkinitcpio/graphs/contributors) to Archlinux's [mkinitcpio](https://git.archlinux.org/mkinitcpio.git/tree/)
- the [members](https://github.com/orgs/archlinux/people) of @archlinux

Hat tip to all of you, and to all developers/contributors of projects like the Linux kernel, Btrfs, GRUB etc., and all those I forgot to mention, as well as to each and every FOSS proponent.
