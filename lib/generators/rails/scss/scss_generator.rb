require "rails/generators/named_base"

module Scss
  module Generators
    class AssetsGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def copy_scss
        template "stylesheet.scss", File.join('app/assets/stylesheets', class_path, "#{file_name}.scss")
      end

    end
  end
end

require "sass/css"
module Sass
  module Generators
    class ScaffoldBase < ::Rails::Generators::NamedBase
      def copy_stylesheet
        dir = "#{File.dirname(__FILE__)}/templates"
	
        file = File.join(dir, "scaffold.scss")
        contents = File.read(file)
        ::Sass::SCSS::Parser.new(contents, "", nil).parse
        create_file "app/assets/stylesheets/scaffolds.#{syntax}", contents
      end
    end
  end
end

module Scss
  module Generators
    class ScaffoldGenerator < ::Sass::Generators::ScaffoldBase
      def syntax() :scss end
    end
  end
end

