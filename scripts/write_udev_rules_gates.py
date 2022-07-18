"""Write udev rules for the Luos gates used in Reachy 2021.

Run this script with sudo.
"""

import glob
from subprocess import run, PIPE


def get_serial_number(port):
    """Get serial number for a gate on a given port."""
    pipe1 = run(
        [f'udevadm info -a -p $(udevadm info -q path -n /{port})'],
        stdout=PIPE,
        shell=True,
    )
    pipe2 = run(
        ['grep ATTRS{serial}'],
        input=pipe1.stdout,
        stdout=PIPE,
        shell=True,
    )
    out = pipe2.stdout.decode().split()
    serial_number = out[0].split('=')[-1]
    return serial_number


def get_rule_msg(serial_number, gate_id):
    """Build a udev rule given a gate serial number."""
    rule = 'KERNEL=="ttyUSB[0-9]", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6015", '
    rule += f'ATTRS{{serial}}=={serial_number}, MODE="666", SYMLINK+="gate{gate_id}"\n'
    return rule


def write_udev_rules():
    """Run main function.

    For each gate on /dev/ttyUSB*, get its serial number, a udev rule associated
    and write it in the local udev file /etc/udev/rules.d/10-local.rules.
    If previous rules were written for the gates, they are deleted.
    """
    rules_gates = []

    with open('/etc/udev/rules.d/10-local.rules', 'r') as f:
        contents = f.readlines()

    for (i, content) in enumerate(contents):
        if "Luos" in content:
            luos_index = i

    contents_ = contents[:luos_index+1]

    for (i, port) in enumerate(glob.glob('/dev/ttyUSB*')[::-1]):
        sn = get_serial_number(port)
        rules_gates.append(get_rule_msg(sn, i))

    with open('/etc/udev/rules.d/10-local.rules', 'w') as fa:
        fa.writelines(contents_ + rules_gates)
        fa.close()


if __name__ == '__main__':
    write_udev_rules()
