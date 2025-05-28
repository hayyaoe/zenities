export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/eww/target/release:$PATH"
export PATH="$HOME/.local/share/solana/install/releases/stable-6b04e8811190f74ebcd1c95c50fa724c11066dfe/solana-release/bin:$PATH"
export PATH="$HOME/development/flutter/bin:$PATH"
export PATH="$HOME/ncspot/target/debug:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$HOME/miniconda3/bin:$PATH"
export ANDROID_HOME=$HOME/Android
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
#export PATH=$PATH:/opt/apache-spark/bin

export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
export PATH="$JAVA_HOME/bin:$PATH"

export SPARK_HOME="/opt/spark"
export PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"

# Initialize Conda in zsh
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
fi
