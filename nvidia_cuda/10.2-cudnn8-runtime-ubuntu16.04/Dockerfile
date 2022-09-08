RUN set -xe   && echo '#!/bin/sh' > /usr/sbin/policy-rc.d  && echo 'exit 101' >> /usr/sbin/policy-rc.d  && chmod +x /usr/sbin/policy-rc.d   && dpkg-divert --local --rename --add /sbin/initctl  && cp -a /usr/sbin/policy-rc.d /sbin/initctl  && sed -i 's/^exit.*/exit 0/' /sbin/initctl   && echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup   && echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean  && echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean  && echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean   && echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages   && echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes   && echo 'Apt::AutoRemove::SuggestsImportant "false";' > /etc/apt/apt.conf.d/docker-autoremove-suggests
RUN rm -rf /var/lib/apt/lists/*
RUN mkdir -p /run/systemd && echo 'docker' > /run/systemd/container
ENV NVARCH=x86_64
ENV NVIDIA_REQUIRE_CUDA=cuda>=10.2 brand=tesla,driver>=418,driver<419
ENV NV_CUDA_CUDART_VERSION=10.2.89-1
RUN apt-get update && apt-get install -y --no-install-recommends     ca-certificates apt-transport-https gnupg-curl &&     NVIDIA_GPGKEY_SUM=a21c1a0b18a4196fa901b833e13c4fa64f094d7d9e8a6495318e7255f0ef23d1 &&     NVIDIA_GPGKEY_FPR=eb693b3035cd5710e231e123a4b469963bf863cc &&     apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/${NVARCH}/3bf863cc.pub &&     apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub &&     echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub &&     echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/${NVARCH} /" > /etc/apt/sources.list.d/cuda.list &&     apt-get purge --auto-remove -y gnupg-curl     && rm -rf /var/lib/apt/lists/*
ENV CUDA_VERSION=10.2.89
RUN apt-get update && apt-get install -y --no-install-recommends     cuda-cudart-10-2=${NV_CUDA_CUDART_VERSION}     cuda-compat-10-2     && ln -s cuda-10.2 /usr/local/cuda &&     rm -rf /var/lib/apt/lists/*
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf &&     echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV NV_CUDA_LIB_VERSION=10.2.89-1
ENV NV_NVTX_VERSION=10.2.89-1
ENV NV_LIBNPP_VERSION=10.2.89-1
ENV NV_LIBCUSPARSE_VERSION=10.2.89-1
ENV NV_LIBCUBLAS_PACKAGE_NAME=libcublas10
ENV NV_LIBCUBLAS_VERSION=10.2.2.89-1
ENV NV_LIBCUBLAS_PACKAGE=libcublas10=10.2.2.89-1
ENV NV_LIBNCCL_PACKAGE_NAME=libnccl2
ENV NV_LIBNCCL_PACKAGE_VERSION=2.12.10-1
ENV NCCL_VERSION=2.12.10
ENV NV_LIBNCCL_PACKAGE=libnccl2=2.12.10-1+cuda10.2
RUN apt-get update && apt-get install -y --no-install-recommends     cuda-libraries-10-2=${NV_CUDA_LIB_VERSION}     cuda-npp-10-2=${NV_LIBNPP_VERSION}     cuda-nvtx-10-2=${NV_NVTX_VERSION}     cuda-cusparse-10-2=${NV_LIBCUSPARSE_VERSION}     ${NV_LIBCUBLAS_PACKAGE}     ${NV_LIBNCCL_PACKAGE}     && rm -rf /var/lib/apt/lists/*
RUN apt-mark hold ${NV_LIBNCCL_PACKAGE_NAME} ${NV_LIBCUBLAS_PACKAGE_NAME}
ENV NV_CUDNN_PACKAGE_VERSION=8.4.0.27-1
ENV NV_CUDNN_VERSION=8.4.0.27
ENV NV_CUDNN_PACKAGE_NAME=libcudnn8
ENV NV_CUDNN_PACKAGE=libcudnn8=8.4.0.27-1+cuda10.2
ENV CUDNN_VERSION=8.4.0.27 
RUN apt-get update && apt-get install -y --no-install-recommends     ${NV_CUDNN_PACKAGE}     ${NV_CUDNN_PACKAGE_DEV}     && apt-mark hold ${NV_CUDNN_PACKAGE_NAME} &&     rm -rf /var/lib/apt/lists/*
