
module Bones::App
class CreateCommand < Command

  def self.initialize_create_command
    synopsis 'bones create [options] <project_name>'

    description <<-__
Create a new project from a Mr Bones project skeleton. The skeleton can
be the default project skeleton from the Mr Bones gem or one of the named
skeletons found in the '~/.mrbones/' folder. A git or svn repository can
be used as the skeleton if the '--repository' flag is given.
    __

    option(standard_options[:directory])
    option(standard_options[:skeleton])
    option(standard_options[:repository])
    option(standard_options[:verbose])
  end

  def run
    raise Error, "Output directory #{output_dir.inspect} already exists." if test ?e, output_dir

    copy_files

    msg = "Created '#{name}'"
    msg << " in directory '#{output_dir}'" if name != output_dir
    stdout.puts msg

    in_directory(output_dir) {
      break unless test ?f, 'Rakefile'
      stdout.puts 'Now you need to fix these files'
      system "#{::Bones::RUBY} -S rake notes"
    }
  end

  def parse( args )
    opts = super args

    config[:name] = args.empty? ? nil : args.join('_')
    config[:output_dir] = name if output_dir.nil?

    if name.nil?
      stdout.puts opts
      exit 1
    end
  end

  def copy_files
    fm = FileManager.new(
      :source => repository || skeleton_dir,
      :destination => output_dir,
      :stdout => stdout,
      :stderr => stderr,
      :verbose => verbose?
    )

    fm.copy
    fm.finalize name
  rescue Bones::App::FileManager::Error => err
    FileUtils.rm_rf output_dir
    msg = "Could not create '#{name}'"
    msg << " in directory '#{output_dir}'" if name != output_dir
    msg << "\n\t#{err.message}"
    raise Error, msg
  rescue Exception => err
    FileUtils.rm_rf output_dir
    msg = "Could not create '#{name}'"
    msg << " in directory '#{output_dir}'" if name != output_dir
    msg << "\n\t#{err.inspect}"
    raise Error, msg
  end

end  # class CreateCommand
end  # module Bones::App

# EOF
