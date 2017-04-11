module LoggerMixin
  LOGS_DIR = File.join(ROOT_DIR, 'logs')
  %x(mkdir -p #{LOGS_DIR})

  def append(text)
    File.open(self::LOG_FILE, 'a') do |log_file|
      log_file.write(text)
    end
  end

  def tail(lines)
    amount = lines.to_i
    amount = self::TAIL_NUMBER if amount < self::TAIL_NUMBER
    return 'Пусто' unless File.exist?(self::LOG_FILE )
    %x(tail -n #{amount} #{self::LOG_FILE})
  end

  def clear
    !!File.delete(self::LOG_FILE)
  rescue
    true
  end

end
