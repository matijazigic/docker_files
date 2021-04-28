FROM ros:rolling
LABEL maintainer="zigic.matija@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt-get update -q && \
    apt-get upgrade -yq && \
    apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata python3-vcstool && \
    rm -rf /var/lib/apt/lists/*
RUN useradd -m -d /home/ubuntu ubuntu -p $(perl -e 'print crypt("ubuntu", "salt"),"\n"') && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN locale-gen en_US en_US.UTF-8
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

USER ubuntu
WORKDIR /home/ubuntu
ENV HOME=/home/ubuntu

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

### ROS2 ###

RUN grep -F "source /opt/ros/$ROS_DISTRO/setup.bash" ~/.bashrc || echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

### UPDATE ###
RUN sudo apt update

# Initialize rosdep
RUN rosdep update

### NAV UNDERLAY REPOS ###
RUN mkdir -p ~/nav2_depend_ws/src
WORKDIR /home/ubuntu/nav2_depend_ws

RUN wget https://raw.githubusercontent.com/ros-planning/navigation2/main/tools/underlay.repos
RUN vcs import ~/nav2_depend_ws/src < underlay.repos
RUN rosdep install -y -r -q --from-paths ~/nav2_depend_ws/src --ignore-src --rosdistro $ROS_DISTRO

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && cd ~/nav2_depend_ws && colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

### NAV ###
RUN mkdir -p ~/nav2_ws/src
WORKDIR /home/ubuntu/nav2_ws

RUN cd src && git clone https://github.com/ros-planning/navigation2.git --branch main
RUN . ~/nav2_depend_ws/install/setup.sh && rosdep install -y -r -q --from-paths src --ignore-src --rosdistro $ROS_DISTRO
RUN . ~/nav2_depend_ws/install/setup.sh && colcon build --symlink-install

### RQT ###
#RUN apt install ~nros-rolling-rqt*

### ENTRY POINT ###
#COPY ./ros_entrypoint.sh /
#RUN sudo chmod +x /ros_entrypoint.sh
#ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
