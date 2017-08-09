#!/bin/bash

#NEWSTR="CISCO-FINISAR  "
 VENDOR="CYBER CYBER CYB"

#SERIAL="FNS17521U7B     "
 SERIAL="CYBER CYBER CYBE"

#PARTNO="FTLX8570D3BCL-C2A   "
 PARTNO="CYBER CYBER CYBER CY"

if [[ ! "${#VENDOR}" = "15" ]] || [[ ! "${#SERIAL}" = "16" ]] || [[ ! "${#PARTNO}" = "20" ]]; then
	echo "NOOOPE!"
	exit 1
fi

echo "Unlocking module"
./unlock.sh
sleep 1

# write vendor
echo "Writing vendor"
writeaddr=20
for chr in $(printf "${VENDOR}" | xxd -p -c1); do
	i2cset -y 9 0x50 0x$(printf "%02x" ${writeaddr}) 0x$chr
	sleep 0.05
	writeaddr=$((writeaddr+1))
done

# write part number
echo "Writing part number"
writeaddr=40
for chr in $(printf "${PARTNO}" | xxd -p -c1); do
	i2cset -y 9 0x50 0x$(printf "%02x" ${writeaddr}) 0x$chr
	sleep 0.05
	writeaddr=$((writeaddr+1))
done

# write serial
echo "Writing serial"
writeaddr=68
for chr in $(printf "${SERIAL}" | xxd -p -c1); do
	i2cset -y 9 0x50 0x$(printf "%02x" ${writeaddr}) 0x$chr
	sleep 0.05
	writeaddr=$((writeaddr+1))
done

echo "Fixing checksum"
./fix-checksum.sh



