# $Id$

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'bones'

task :default => 'spec:run'

PROJ.name = 'bones'
PROJ.summary = 'Mr Bones is a handy tool that builds a skeleton for your new Ruby projects'
PROJ.authors = 'Tim Pease'
PROJ.email = 'tim.pease@gmail.com'
PROJ.url = 'http://codeforpeople.rubyforge.org/bones'
PROJ.description = paragraphs_of('README.txt', 3).join("\n\n")
PROJ.changes = paragraphs_of('History.txt', 0..1).join("\n\n")
PROJ.rubyforge_name = 'codeforpeople'
PROJ.rdoc_remote_dir = 'bones'
PROJ.version = Bones::VERSION

PROJ.exclude << '^doc'
PROJ.rdoc_exclude << '^data'

PROJ.spec_opts << '--color'

# EOF