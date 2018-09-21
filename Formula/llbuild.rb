class Llbuild < Formula
  desc "A low-level build system, used by Xcode and the Swift Package Manager"
  homepage "https://github.com/apple/swift-llbuild"
  url "https://codeload.github.com/apple/swift-llbuild/tar.gz/swift-4.2-DEVELOPMENT-SNAPSHOT-2018-08-16-a"
  sha256 "2279679b9aec592476b98353a6ed7b9e6632634d82bffe005f1e78cdb8bc22dc"

  depends_on "cmake" => :build
  patch :DATA

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "test", "-f", "#{bin}/llbuild"
  end
end
__END__
diff --git a/products/llbuild/CMakeLists.txt b/products/llbuild/CMakeLists.txt
index 6ec9d16..030fc14 100644
--- a/products/llbuild/CMakeLists.txt
+++ b/products/llbuild/CMakeLists.txt
@@ -13,3 +13,14 @@ target_link_libraries(llbuild
 if(NOT ${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
   target_link_libraries(llbuild curses)
 endif()
+
+install(TARGETS llbuild
+        COMPONENT llbuild
+        DESTINATION bin)
+
+add_custom_target(install-llbuild
+                  DEPENDS llbuild
+                  COMMENT "Installing llbuild..."
+                  COMMAND "${CMAKE_COMMAND}"
+                          -DCMAKE_INSTALL_COMPONENT=llbuild
+                          -P "${CMAKE_BINARY_DIR}/cmake_install.cmake")
