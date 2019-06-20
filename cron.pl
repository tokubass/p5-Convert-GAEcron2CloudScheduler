#!/usr/bin/env perl

# convert GAE cron.yaml to Cloud Scheduler
# https://cloud.google.com/appengine/docs/standard/go/config/cronref?hl=ja
# https://cloud.google.com/sdk/gcloud/reference/beta/scheduler/jobs/create/app-engine
use strict;
use warnings;
use YAML::Tiny;

sub help {
    warn <<'END';
help:
  $ cron.fatpack.pl  cron.yaml [GAE version]
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
