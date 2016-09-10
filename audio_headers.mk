include $(CLEAR_VARS)

LOCAL_PATH := $(call my-dir)

$(shell mkdir -p $$PWD/out/target/product/y6/obj/include)
#$(shell cp  -rn $$PWD/device/huawei/y6/include/common $$PWD/out/target/product/y6/obj/include/)
#$(shell cp  -rn $$PWD/device/huawei/y6/include/mm-audio $$PWD/out/target/product/y6/obj/include/)
#$(shell cp  -rn $$PWD/device/huawei/y6/include/libperipheralclient $$PWD/out/target/product/y6/obj/include/)
$(shell cp  -rn $$PWD/device/huawei/y6/include $$PWD/out/target/product/y6/obj/)