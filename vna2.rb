class Vna2 < Formula
  desc "Second version of my 1MHz to 6GHz USB based vector network analyzer"
  homepage ""
  license "GPL-3.0"
  #url "https://github.com/jankae/VNA2/archive/v0.1.0-alpha.2.tar.gz"
  #sha256 "9733127833feeef6388b43751b01577b946c36e05c309efa3df809972b0a70b8"
  head "https://github.com/jankae/VNA2.git"

  depends_on "qt"
  depends_on "libusb"

  patch :DATA

  def install
    cd "Software/PC_Application"
    system "qmake"
    system "make"
    prefix.install "VNA2.app"
  end

  test do
    system "false"
  end
end

__END__
diff --git a/Software/PC_Application/Application.pro b/Software/PC_Application/Application.pro
index ebc52e2..30068d8 100644
--- a/Software/PC_Application/Application.pro
+++ b/Software/PC_Application/Application.pro
@@ -221,6 +221,8 @@ SOURCES += \
 LIBS += -lusb-1.0
 unix:LIBS += -L/usr/lib/
 win32:LIBS += -L"$$_PRO_FILE_PWD_" # Github actions placed libusb here
+osx:INCPATH += /usr/local/include
+osx:LIBS += $(shell pkg-config --libs libusb-1.0)
 
 QT += widgets
 
@@ -268,9 +270,10 @@ DISTFILES +=
 RESOURCES += \
     icons.qrc
 
-CONFIG += c++14
+CONFIG += c++17
 REVISION = $$system(git rev-parse HEAD)
 DEFINES += GITHASH=\\"\"$$REVISION\\"\"
 DEFINES += FW_MAJOR=0 FW_MINOR=1 FW_PATCH=0 FW_SUFFIX=\\"\"-alpha.2\\"\"
 DEFINES -= _UNICODE UNICODE
 
+TARGET=VNA2
diff --git a/Software/PC_Application/averaging.h b/Software/PC_Application/averaging.h
index af9499a..7745b3b 100644
--- a/Software/PC_Application/averaging.h
+++ b/Software/PC_Application/averaging.h
@@ -3,6 +3,7 @@
 
 
 #include "Device/device.h"
+#include <array>
 #include <deque>
 #include <complex>
