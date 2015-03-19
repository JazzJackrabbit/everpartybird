require 'rubygems'
require 'launchy'
require 'fileutils'

class HTMLWorker
  def self.wrap(tags, style="")
    "<html>\n
      <head>\n
        <style>\n
          #{style}\n
        </style>\n  
      </head>\n
      <body>\n
        #{tags}\n
      </body>\n
    </html>"
  end

  def self.save(filename, directory, html)
    dir = File.join( File.dirname(__FILE__), directory )
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    path = "#{dir}/#{filename}"

    File.open(path, 'w') do |f|
      f.write html
    end
  end

  def self.open(html, tmp_directory='../tmp')
    dir = File.join( File.dirname(__FILE__), tmp_directory )
    filename = "#{rand_str(8)}.html"
    path = "#{dir}/#{filename}"

    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    save(filename, tmp_directory, html)
    Launchy.open(path)
  
    # Delete tmp files
    sleep 5
    FileUtils.rm_rf(dir)
  end

  protected
  def self.rand_str(len)
    (1..len).map{65.+(rand(26)).chr}.join.downcase
  end
end