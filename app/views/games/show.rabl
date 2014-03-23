object @game

attributes :id, :name, :rom_file_name, :rom_file_size, :rom_updated_at, :rom_content_type, :deleted_at

child(system: :system) { attributes :id }
