tags: #linux

IIO Buffered Data Capture
=========================

    $ modprobe iio-trig-hrtimer
    $ mkdir /sys/kernel/config/iio/triggers/hrtimer/trigger0
    $ echo 50 > /sys/bus/iio/devices/trigger0/sampling_frequency $ cd /sys/bus/iio/devices/iio_device0
    $ echo trigger0 > trigger/current_trigger
    $ echo 1 > scan_elements/in_temp_en
    $ echo 1 > scan_elements/in_temp_ambient_en
    $ echo 1 > scan_elements/in_timestamp_en
    $ echo 1 > buffer/enable

[ELC 2017 Industrial I/O]

  [ELC 2017 Industrial I/O]: https://elinux.org/images/b/ba/ELC_2017_-_Industrial_IO_and_You-_Nonsense_Hacks%21.pdf
