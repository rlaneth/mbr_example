# mbr_example

`mbr_example` is a simple 16-bit x86 assembly boot sector program which,
once run, prints a fixed quote on programming to the screen. It is made
for learning and demonstration purposes.

## Requirements

To compile and run the code, you will need:

- `nasm`
- `qemu-system-i386`

In a Debian-based Linux distribution, you might be able to install those
requirements using `apt` as in the following example:

```bash
apt update && apt install -y nasm qemu-system-x86
```

## Building and running

To build the code, run the convenience bash script called `build.sh` in
the root of the project's repository:

```bash
./build.sh
```

This will create a binary file called `demo` in the `bin` directory.

To build and run the code in qemu, use the `--run` flag:

```bash
./build.sh --run
```

This will start qemu with the built binary, and you will see the
program's output.

## Screenshot

![Screenshot of mbr_example running in QEMU](https://github.com/rlaneth/mbr_example/blob/master/SCREENSHOT.png?raw=true)

## License
This project is available under [The Unlicense](license). Feel free to
use it for any purpose, commercial or non-commercial.

[license]: https://github.com/rlaneth/mbr_example/blob/master/LICENSE.md