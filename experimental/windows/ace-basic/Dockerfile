ARG FROMIMAGE=mcr.microsoft.com/windows/servercore:ltsc2022
#ARG FROMIMAGE=jenkins/agent:windowsservercore-ltsc2019
FROM ${FROMIMAGE}

# docker build -t ace-basic:13.0.1.0-windows .

# Update as needed
ARG DOWNLOAD_URL=https://iwm.dhe.ibm.com/sdfdl/v2/regs2/mbford/Xa.2/Xb.WJL1CuPI9gANmbDdDxOhZ8PDHiJ0fYKPUUM7e4LXUys/Xc.13.0.1.0-ACE-WIN64-EVALUATION.zip/Xd./Xf.lPr.D1vk/Xg.12203400/Xi.swg-wmbfd/XY.regsrvs/XZ.224GETTSkG6f3cguPd6ugJwv0vB5Q9nY/13.0.1.0-ACE-WIN64-EVALUATION.zip
#ARG DOWNLOAD_URL=http://10.0.0.201:49177/ace/13.0.1.0-ACE-WIN64-EVALUATION.zip

WORKDIR c:\\tmp

# The commands to download and install the ACE product are more easily
# run from a CMD file than from within the Dockerfile itself.
COPY download-and-install-ace.cmd c:\\tmp\\download-and-install-ace.cmd
RUN c:\\tmp\\download-and-install-ace.cmd %DOWNLOAD_URL%

# Used to debug individual pieces
#
#COPY download-ace.cmd c:\\tmp\\download-ace.cmd
#RUN c:\\tmp\\download-ace.cmd %DOWNLOAD_URL%
#COPY unpack-ace.cmd c:\\tmp\\unpack-ace.cmd
#RUN c:\\tmp\\unpack-ace.cmd
#COPY install-ace.cmd c:\\tmp\\install-ace.cmd
#RUN c:\\tmp\\install-ace.cmd

# Could also be set to ContainerUser
USER ContainerAdministrator
