class ReservedName

  def self.list
    @list ||= YAML.load_file Rails.root.join('config', 'reserved_usernames.yml')
  end

end