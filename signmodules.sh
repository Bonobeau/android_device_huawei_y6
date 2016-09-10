#!/bin/bash

#Module signing workaround... at least until make does it by itself.

for a in $(find out/target/product/y6/system -type f -name *.ko)
do
echo "Performing signing workaround on "$a
kernel/huawei/msm8909/scripts/sign-file sha512 out/target/product/y6/obj/KERNEL_OBJ/signing_key.priv out/target/product/y6/obj/KERNEL_OBJ/signing_key.x509 $a
done

