use ExtUtils::MakeMaker;

mkdir "./lib";
mkdir "./lib/BWT";
mkdir "./lib/SA";
mkdir "./t/";
system("cp src/lib/BWT/* ./lib/BWT");
system("cp  src/lib/SA/* ./lib/SA");
system("cp  src/t/* ./t/");
system("cp  src/apps/* ./bin/");


WriteMakefile(
	NAME		=> 'BWT',
	AUTHOR   => q{Robert Bakaric <rbakaric@irb.hr>},
	LICENSE  => 'GNU GENERAL PUBLIC LICENSE Version 3',
	ABSTRACT => 'Simple Burrows–Wheeler transform demo program',
	VERSION	=> '0.01',

	dist		=> { 'COMPRESS' => 'gzip' },
	PREREQ_PM => {
        "Getopt::Long" => 0,
        "File::Slurp" => 0,
    },
    META_ADD => {
        provides => {
            'BWT::Simple' => {
               file => 'Simple.pm',
               version => '0.01',
            },
            'SA::SuffixArray' => {
               file => 'SuffixArray.pm',
               version => '0.01',
            },
        },
    },
);



