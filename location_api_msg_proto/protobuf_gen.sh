#/bin/bash

# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear

########################################OpenWRT############################################
# protobuf_gen.sh --> Used in OpenWRT Build System
# Description:
# Util script to compile the proto files using protoc to generate the header and C file.
###########################################################################################

protogen_script_path=$(realpath $0)
pkg_build_dir_path=$(dirname $protogen_script_path)
echo "Current directory $pkg_build_dir_path"

protobuf_protoc_path=$1/bin/protoc
echo "Binary protoc path is : $protobuf_protoc_path"

if ! [ -e $protobuf_protoc_path ]
then
    echo "ERROR!! Protoc - $protobuf_protoc_path - is not found..."
    exit 1
fi

echo "Protobuf version is: $(eval $protobuf_protoc_path --version)"

## array of .proto files. Add any new .proto files to this array.
src_proto_files=(LocationApiDataTypes.proto LocationApiMsg.proto)

for src_file in ${src_proto_files[@]}; do
    echo -e "\nProcessing $src_file"
    echo " >> Running protoc"
    cmd=$protobuf_protoc_path' --proto_path=$pkg_build_dir_path --cpp_out=$pkg_build_dir_path/src '$src_file
    eval $cmd
    if [ $? -eq 0 ]; then
        echo "SUCCESS !!! protoc compilation"
    else
        echo "ERROR!! protoc compilation failed"
        exit 1
    fi
done
