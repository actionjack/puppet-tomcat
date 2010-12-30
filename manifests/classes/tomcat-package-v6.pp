/*

== Class: tomcat::package::v6

Installs tomcat 6.0.X using your systems package manager.

Class variables:
- *$log4j_conffile*: see tomcat

Requires:
- java to be previously installed

Tested on:
- Debian Lenny (using backported packages from Squeeze)

Usage:
  include tomcat::package::v6

*/
class tomcat::package::v6 inherits tomcat {

  $tomcat = $operatingsystem ? {
    CentOS => "tomcat6",
    RedHat => "tomcat6",
    Debian => "tomcat6",
    Ubuntu => "tomcat6",
  }

  $tomcat_home = "/usr/share/tomcat6"

  # Workaround while tomcat-juli.jar and tomcat-juli-adapters.jar aren't
  # included in tomcat6-* packages.
  include tomcat::juli

  include tomcat::package

  file { $tomcat_home:
    ensure  => directory,
    require => Package["tomcat"],
  }

  File["commons-logging.jar"] {
    path => $operatingsystem ? {
      CentOS  => "/usr/share/tomcat6/lib/commons-logging.jar",
      RedHat  => "/usr/share/tomcat6/lib/commons-logging.jar",
      Debian  => "/usr/share/tomcat6/lib/commons-logging.jar",
    },
  }

  File["log4j.jar"] {
    path => $operatingsystem ? {
      CentOS  => "/usr/share/tomcat6/lib/log4j.jar",
      RedHat  => "/usr/share/tomcat6/lib/log4j.jar",
      Debian  => "/usr/share/tomcat6/lib/log4j.jar",
    },
  }

  File["log4j.properties"] {
    path => $operatingsystem ? {
      CentOS  => "/usr/share/tomcat6/lib/log4j.properties",
      RedHat  => "/usr/share/tomcat6/lib/log4j.properties",
      Debian  => "/usr/share/tomcat6/lib/log4j.properties",
    },
  }

}
