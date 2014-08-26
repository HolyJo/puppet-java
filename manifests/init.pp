class java::install {
    package { 'java-1.6.0-openjdk':
        ensure => installed
    }

    package { 'java-1.6.0-openjdk-devel':
        ensure => installed
    }
}

class java::config {
    $profile="#JAVA Environment variables 
    export JAVA_HOME=/usr/lib/jvm/jre-1.6.0-openjdk.x86_64/"

    define append_if_no_such_line($file, $line, $refreshonly = 'false') {
        exec { "/bin/echo '$line' >> '$file'":
            unless      => "/bin/grep -Fxqe '$line' '$file'",
            path        => "/bin",
            refreshonly => $refreshonly,
        }
    }

    append_if_no_such_line{ java_profile:
        file => "/etc/profile",
        line => "$profile"
    }
}

class java {
    include java::install, java::config
}
