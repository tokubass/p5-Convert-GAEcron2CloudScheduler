#!/usr/bin/env perl

# This chunk of stuff was generated by App::FatPacker. To find the original
# file's code, look for the end of this BEGIN block or the string 'FATPACK'
BEGIN {
my %fatpacked;

$fatpacked{"YAML/Tiny.pm"} = '#line '.(1+__LINE__).' "'.__FILE__."\"\n".<<'YAML_TINY';
  use 5.008001;use strict;use warnings;package YAML::Tiny;our$VERSION='1.73';use Exporter;our@ISA=qw{Exporter};our@EXPORT=qw{Load Dump};our@EXPORT_OK=qw{LoadFile DumpFile freeze thaw};sub Dump {return YAML::Tiny->new(@_)->_dump_string}sub Load {my$self=YAML::Tiny->_load_string(@_);if (wantarray){return @$self}else {return$self->[-1]}}BEGIN {*freeze=\&Dump;*thaw=\&Load}sub DumpFile {my$file=shift;return YAML::Tiny->new(@_)->_dump_file($file)}sub LoadFile {my$file=shift;my$self=YAML::Tiny->_load_file($file);if (wantarray){return @$self}else {return$self->[-1]}}sub new {my$class=shift;bless [@_ ],$class}sub read_string {my$self=shift;$self->_load_string(@_)}sub write_string {my$self=shift;$self->_dump_string(@_)}sub read {my$self=shift;$self->_load_file(@_)}sub write {my$self=shift;$self->_dump_file(@_)}my@UNPRINTABLE=qw(0 x01 x02 x03 x04 x05 x06 a b t n v f r x0E x0F x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x1A e x1C x1D x1E x1F);my%UNESCAPES=(0=>"\x00",z=>"\x00",N=>"\x85",a=>"\x07",b=>"\x08",t=>"\x09",n=>"\x0a",v=>"\x0b",f=>"\x0c",r=>"\x0d",e=>"\x1b",'\\'=>'\\',);my%QUOTE=map {$_=>1}qw{null true false};my$re_capture_double_quoted=qr/\"([^\\"]*(?:\\.[^\\"]*)*)\"/;my$re_capture_single_quoted=qr/\'([^\']*(?:\'\'[^\']*)*)\'/;my$re_capture_unquoted_key=qr/([^:]+(?::+\S(?:[^:]*|.*?(?=:)))*)(?=\s*\:(?:\s+|$))/;my$re_trailing_comment=qr/(?:\s+\#.*)?/;my$re_key_value_separator=qr/\s*:(?:\s+(?:\#.*)?|$)/;sub _load_file {my$class=ref $_[0]? ref shift : shift;my$file=shift or $class->_error('You did not specify a file name');$class->_error("File '$file' does not exist")unless -e $file;$class->_error("'$file' is a directory, not a file")unless -f _;$class->_error("Insufficient permissions to read '$file'")unless -r _;open(my$fh,"<:unix:encoding(UTF-8)",$file);unless ($fh){$class->_error("Failed to open file '$file': $!")}if (_can_flock()){flock($fh,Fcntl::LOCK_SH())or warn "Couldn't lock '$file' for reading: $!"}my$contents=eval {use warnings FATAL=>'utf8';local $/;<$fh>};if (my$err=$@){$class->_error("Error reading from file '$file': $err")}unless (close$fh){$class->_error("Failed to close file '$file': $!")}$class->_load_string($contents)}sub _load_string {my$class=ref $_[0]? ref shift : shift;my$self=bless [],$class;my$string=$_[0];eval {unless (defined$string){die \"Did not provide a string to load"}if (utf8::is_utf8($string)&&!utf8::valid($string)){die \<<'...'}utf8::upgrade($string);$string =~ s/^\x{FEFF}//;return$self unless length$string;my@lines=grep {!/^\s*(?:\#.*)?\z/}split /(?:\015{1,2}\012|\015|\012)/,$string;@lines and $lines[0]=~ /^\%YAML[: ][\d\.]+.*\z/ and shift@lines;my$in_document=0;while (@lines){if ($lines[0]=~ /^---\s*(?:(.+)\s*)?\z/){shift@lines;if (defined $1 and $1 !~ /^(?:\#.+|\%YAML[: ][\d\.]+)\z/){push @$self,$self->_load_scalar("$1",[undef ],\@lines);next}$in_document=1}if (!@lines or $lines[0]=~ /^(?:---|\.\.\.)/){push @$self,undef;while (@lines and $lines[0]!~ /^---/){shift@lines}$in_document=0}elsif (!$in_document && @$self){die \"YAML::Tiny failed to classify the line '$lines[0]'"}elsif ($lines[0]=~ /^\s*\-(?:\s|$|-+$)/){my$document=[];push @$self,$document;$self->_load_array($document,[0 ],\@lines)}elsif ($lines[0]=~ /^(\s*)\S/){my$document={};push @$self,$document;$self->_load_hash($document,[length($1)],\@lines)}else {die \"YAML::Tiny failed to classify the line '$lines[0]'"}}};my$err=$@;if (ref$err eq 'SCALAR'){$self->_error(${$err})}elsif ($err){$self->_error($err)}return$self}sub _unquote_single {my ($self,$string)=@_;return '' unless length$string;$string =~ s/\'\'/\'/g;return$string}sub _unquote_double {my ($self,$string)=@_;return '' unless length$string;$string =~ s/\\"/"/g;$string =~ s{\\([Nnever\\fartz0b]|x([0-9a-fA-F]{2}))}
  Read an invalid UTF-8 string (maybe mixed UTF-8 and 8-bit character set).
  Did you decode with lax ":utf8" instead of strict ":encoding(UTF-8)"?
  ...
           {(length($1)>1)?pack("H2",$2):$UNESCAPES{$1}}gex;return$string}sub _load_scalar {my ($self,$string,$indent,$lines)=@_;$string =~ s/\s*\z//;return undef if$string eq '~';if ($string =~ /^$re_capture_single_quoted$re_trailing_comment\z/){return$self->_unquote_single($1)}if ($string =~ /^$re_capture_double_quoted$re_trailing_comment\z/){return$self->_unquote_double($1)}if ($string =~ /^[\'\"!&]/){die \"YAML::Tiny does not support a feature in line '$string'"}return {}if$string =~ /^{}(?:\s+\#.*)?\z/;return []if$string =~ /^\[\](?:\s+\#.*)?\z/;if ($string !~ /^[>|]/){die \"YAML::Tiny found illegal characters in plain scalar: '$string'" if$string =~ /^(?:-(?:\s|$)|[\@\%\`])/ or $string =~ /:(?:\s|$)/;$string =~ s/\s+#.*\z//;return$string}die \"YAML::Tiny failed to find multi-line scalar content" unless @$lines;$lines->[0]=~ /^(\s*)/;$indent->[-1]=length("$1");if (defined$indent->[-2]and $indent->[-1]<= $indent->[-2]){die \"YAML::Tiny found bad indenting in line '$lines->[0]'"}my@multiline=();while (@$lines){$lines->[0]=~ /^(\s*)/;last unless length($1)>= $indent->[-1];push@multiline,substr(shift(@$lines),$indent->[-1])}my$j=(substr($string,0,1)eq '>')? ' ' : "\n";my$t=(substr($string,1,1)eq '-')? '' : "\n";return join($j,@multiline).$t}sub _load_array {my ($self,$array,$indent,$lines)=@_;while (@$lines){if ($lines->[0]=~ /^(?:---|\.\.\.)/){while (@$lines and $lines->[0]!~ /^---/){shift @$lines}return 1}$lines->[0]=~ /^(\s*)/;if (length($1)< $indent->[-1]){return 1}elsif (length($1)> $indent->[-1]){die \"YAML::Tiny found bad indenting in line '$lines->[0]'"}if ($lines->[0]=~ /^(\s*\-\s+)[^\'\"]\S*\s*:(?:\s+|$)/){my$indent2=length("$1");$lines->[0]=~ s/-/ /;push @$array,{};$self->_load_hash($array->[-1],[@$indent,$indent2 ],$lines)}elsif ($lines->[0]=~ /^\s*\-\s*\z/){shift @$lines;unless (@$lines){push @$array,undef;return 1}if ($lines->[0]=~ /^(\s*)\-/){my$indent2=length("$1");if ($indent->[-1]==$indent2){push @$array,undef}else {push @$array,[];$self->_load_array($array->[-1],[@$indent,$indent2 ],$lines)}}elsif ($lines->[0]=~ /^(\s*)\S/){push @$array,{};$self->_load_hash($array->[-1],[@$indent,length("$1")],$lines)}else {die \"YAML::Tiny failed to classify line '$lines->[0]'"}}elsif ($lines->[0]=~ /^\s*\-(\s*)(.+?)\s*\z/){shift @$lines;push @$array,$self->_load_scalar("$2",[@$indent,undef ],$lines)}elsif (defined$indent->[-2]and $indent->[-1]==$indent->[-2]){return 1}else {die \"YAML::Tiny failed to classify line '$lines->[0]'"}}return 1}sub _load_hash {my ($self,$hash,$indent,$lines)=@_;while (@$lines){if ($lines->[0]=~ /^(?:---|\.\.\.)/){while (@$lines and $lines->[0]!~ /^---/){shift @$lines}return 1}$lines->[0]=~ /^(\s*)/;if (length($1)< $indent->[-1]){return 1}elsif (length($1)> $indent->[-1]){die \"YAML::Tiny found bad indenting in line '$lines->[0]'"}my$key;if ($lines->[0]=~ s/^\s*$re_capture_single_quoted$re_key_value_separator//){$key=$self->_unquote_single($1)}elsif ($lines->[0]=~ s/^\s*$re_capture_double_quoted$re_key_value_separator//){$key=$self->_unquote_double($1)}elsif ($lines->[0]=~ s/^\s*$re_capture_unquoted_key$re_key_value_separator//){$key=$1;$key =~ s/\s+$//}elsif ($lines->[0]=~ /^\s*\?/){die \"YAML::Tiny does not support a feature in line '$lines->[0]'"}else {die \"YAML::Tiny failed to classify line '$lines->[0]'"}if (exists$hash->{$key}){warn "YAML::Tiny found a duplicate key '$key' in line '$lines->[0]'"}if (length$lines->[0]){$hash->{$key}=$self->_load_scalar(shift(@$lines),[@$indent,undef ],$lines)}else {shift @$lines;unless (@$lines){$hash->{$key}=undef;return 1}if ($lines->[0]=~ /^(\s*)-/){$hash->{$key}=[];$self->_load_array($hash->{$key},[@$indent,length($1)],$lines)}elsif ($lines->[0]=~ /^(\s*)./){my$indent2=length("$1");if ($indent->[-1]>= $indent2){$hash->{$key}=undef}else {$hash->{$key}={};$self->_load_hash($hash->{$key},[@$indent,length($1)],$lines)}}}}return 1}sub _dump_file {my$self=shift;require Fcntl;my$file=shift or $self->_error('You did not specify a file name');my$fh;if (_can_flock()){my$flags=Fcntl::O_WRONLY()|Fcntl::O_CREAT();sysopen($fh,$file,$flags)or $self->_error("Failed to open file '$file' for writing: $!");binmode($fh,":raw:encoding(UTF-8)");flock($fh,Fcntl::LOCK_EX())or warn "Couldn't lock '$file' for reading: $!";truncate$fh,0;seek$fh,0,0}else {open$fh,">:unix:encoding(UTF-8)",$file}print {$fh}$self->_dump_string;unless (close$fh){$self->_error("Failed to close file '$file': $!")}return 1}sub _dump_string {my$self=shift;return '' unless ref$self && @$self;my$indent=0;my@lines=();eval {for my$cursor (@$self){push@lines,'---';if (!defined$cursor){}elsif (!ref$cursor){$lines[-1].= ' ' .$self->_dump_scalar($cursor)}elsif (ref$cursor eq 'ARRAY'){unless (@$cursor){$lines[-1].= ' []';next}push@lines,$self->_dump_array($cursor,$indent,{})}elsif (ref$cursor eq 'HASH'){unless (%$cursor){$lines[-1].= ' {}';next}push@lines,$self->_dump_hash($cursor,$indent,{})}else {die \("Cannot serialize " .ref($cursor))}}};if (ref $@ eq 'SCALAR'){$self->_error(${$@})}elsif ($@){$self->_error($@)}join '',map {"$_\n"}@lines}sub _has_internal_string_value {my$value=shift;my$b_obj=B::svref_2object(\$value);return$b_obj->FLAGS & B::SVf_POK()}sub _dump_scalar {my$string=$_[1];my$is_key=$_[2];my$has_string_flag=_has_internal_string_value($string);return '~' unless defined$string;return "''" unless length$string;if (Scalar::Util::looks_like_number($string)){if ($is_key || $has_string_flag){return qq['$string']}else {return$string}}if ($string =~ /[\x00-\x09\x0b-\x0d\x0e-\x1f\x7f-\x9f\'\n]/){$string =~ s/\\/\\\\/g;$string =~ s/"/\\"/g;$string =~ s/\n/\\n/g;$string =~ s/[\x85]/\\N/g;$string =~ s/([\x00-\x1f])/\\$UNPRINTABLE[ord($1)]/g;$string =~ s/([\x7f-\x9f])/'\x' . sprintf("%X",ord($1))/ge;return qq|"$string"|}if ($string =~ /(?:^[~!@#%&*|>?:,'"`{}\[\]]|^-+$|\s|:\z)/ or $QUOTE{$string}){return "'$string'"}return$string}sub _dump_array {my ($self,$array,$indent,$seen)=@_;if ($seen->{refaddr($array)}++){die \"YAML::Tiny does not support circular references"}my@lines=();for my$el (@$array){my$line=('  ' x $indent).'-';my$type=ref$el;if (!$type){$line .= ' ' .$self->_dump_scalar($el);push@lines,$line}elsif ($type eq 'ARRAY'){if (@$el){push@lines,$line;push@lines,$self->_dump_array($el,$indent + 1,$seen)}else {$line .= ' []';push@lines,$line}}elsif ($type eq 'HASH'){if (keys %$el){push@lines,$line;push@lines,$self->_dump_hash($el,$indent + 1,$seen)}else {$line .= ' {}';push@lines,$line}}else {die \"YAML::Tiny does not support $type references"}}@lines}sub _dump_hash {my ($self,$hash,$indent,$seen)=@_;if ($seen->{refaddr($hash)}++){die \"YAML::Tiny does not support circular references"}my@lines=();for my$name (sort keys %$hash){my$el=$hash->{$name};my$line=('  ' x $indent).$self->_dump_scalar($name,1).":";my$type=ref$el;if (!$type){$line .= ' ' .$self->_dump_scalar($el);push@lines,$line}elsif ($type eq 'ARRAY'){if (@$el){push@lines,$line;push@lines,$self->_dump_array($el,$indent + 1,$seen)}else {$line .= ' []';push@lines,$line}}elsif ($type eq 'HASH'){if (keys %$el){push@lines,$line;push@lines,$self->_dump_hash($el,$indent + 1,$seen)}else {$line .= ' {}';push@lines,$line}}else {die \"YAML::Tiny does not support $type references"}}@lines}our$errstr='';sub _error {require Carp;$errstr=$_[1];$errstr =~ s/ at \S+ line \d+.*//;Carp::croak($errstr)}my$errstr_warned;sub errstr {require Carp;Carp::carp("YAML::Tiny->errstr and \$YAML::Tiny::errstr is deprecated")unless$errstr_warned++;$errstr}use B;my$HAS_FLOCK;sub _can_flock {if (defined$HAS_FLOCK){return$HAS_FLOCK}else {require Config;my$c=\%Config::Config;$HAS_FLOCK=grep {$c->{$_}}qw/d_flock d_fcntl_can_lock d_lockf/;require Fcntl if$HAS_FLOCK;return$HAS_FLOCK}}use Scalar::Util ();BEGIN {local $@;if (eval {Scalar::Util->VERSION(1.18)}){*refaddr=*Scalar::Util::refaddr}else {eval <<'END_PERL'}}delete$YAML::Tiny::{refaddr};1;
  # Scalar::Util failed to load or too old
  sub refaddr {
      my $pkg = ref($_[0]) or return undef;
      if ( !! UNIVERSAL::can($_[0], 'can') ) {
          bless $_[0], 'Scalar::Util::Fake';
      } else {
          $pkg = undef;
      }
      "$_[0]" =~ /0x(\w+)/;
      my $i = do { no warnings 'portable'; hex $1 };
      bless $_[0], $pkg if defined $pkg;
      $i;
  }
  END_PERL
YAML_TINY

s/^  //mg for values %fatpacked;

my $class = 'FatPacked::'.(0+\%fatpacked);
no strict 'refs';
*{"${class}::files"} = sub { keys %{$_[0]} };

if ($] < 5.008) {
  *{"${class}::INC"} = sub {
    if (my $fat = $_[0]{$_[1]}) {
      my $pos = 0;
      my $last = length $fat;
      return (sub {
        return 0 if $pos == $last;
        my $next = (1 + index $fat, "\n", $pos) || $last;
        $_ .= substr $fat, $pos, $next - $pos;
        $pos = $next;
        return 1;
      });
    }
  };
}

else {
  *{"${class}::INC"} = sub {
    if (my $fat = $_[0]{$_[1]}) {
      open my $fh, '<', \$fat
        or die "FatPacker error loading $_[1] (could be a perl installation issue?)";
      return $fh;
    }
    return;
  };
}

unshift @INC, bless \%fatpacked, $class;
  } # END OF FATPACK CODE


# convert GAE cron.yaml to Cloud Scheduler
# https://cloud.google.com/appengine/docs/standard/go/config/cronref?hl=ja
# https://cloud.google.com/sdk/gcloud/reference/beta/scheduler/jobs/create/app-engine
use strict;
use warnings;
use YAML::Tiny;

sub help {
    warn <<'END';
help:
  $ cron.fatpack.pl  yamlファイル  [GAEのversion名]
END
    exit;
}

my $yaml_file = shift || help();
my $version = shift;
    
my $yaml = YAML::Tiny->read($yaml_file);

for my $job (@{ $yaml->[0]{cron} }){
    (my $id1 = $job->{url}) =~ s{/}{_}g;
    (my $id2 = $job->{schedule}) =~ s{[: ]}{_}g;

    my %option = (
        "--http-method"  => "get",
        "--relative-url" => $job->{url},
        "--schedule"     => $job->{schedule},
        "--service"      => ($job->{target} || "default"),
        "--time-zone"    => ($job->{timezone} || "utc"),
        $version ? ("--version" => $version) : (),
    );

    printf("gcloud beta scheduler jobs create app-engine %s %s\n",
           "job_${id1}_${id2}",
           join(" " =>  map { sprintf('%s="%s"', $_, $option{$_}) } sort keys %option)
       );

}