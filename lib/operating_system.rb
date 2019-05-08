# Module to handle the OS commands needed for CKey2bibframe conversion
module OperatingSystem
  # Executes a system command in a subprocess.
  # The method will return stdout from the command if execution was successful.
  # The method will raise an exception if if execution fails.
  # The exception's message will contain the explaination of the failure.
  # @param [String] command the command to be executed
  # @return [String] stdout from the command if execution was successful

  def execute_command(command)
    status, stdout, stderr = systemu(command)
    raise stderr if status.exitstatus.nonzero?

    stdout
  rescue StandardError
    msg = "Command failed to execute: [#{command}] caused by
          <STDERR = #{stderr}>"
    msg << " STDOUT = #{stdout}" if stdout.present?
    raise msg
  end
end
