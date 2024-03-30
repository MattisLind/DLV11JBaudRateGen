library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity baudrategen is
port (
   clk_in: in std_logic; -- clock input on FPGA
   clk_out: out std_logic; -- clock output 
   baud_rate_sel: in std_logic_vector(3 downto 0)
  );
end baudrategen;

architecture Behavioral of baudrategen is
signal divisor: std_logic_vector(27 downto 0):=(others =>'0');
signal 460800bps, 230400bps, 115200bps, 38400bps, 19200bps, 9600bps, 4800bps, 2400bps, 1200bps, 600bps,  300bps, 110bps: std_logic;
signal divide_by_three std_logic_vector(1 downto 0):=(others=>'0');
begin
  460800bps <= clk_in;
  process(460800bps)
  begin
    if(rising_edge(460800bps)) then
      230400bps <= not 230400bps; 
    end if;
  end process;
  process(230400bps)
  begin
    if(rising_edge(230400bps)) then
      115200bps <= not 115200bps; 
    end if;
  end process;
  process(115200bps)
  begin
    if(rising_edge(230400bps)) then
      if divide_by_three = 0 then
        divide_by_three <= "01";
        38400bps <= not 38400bps;
      end if
      if divide_by_three = 1 then
        divide_by_three <= "10";
      end if      
      if divide_by_three = 2 then
        divide_by_three <= "00";
      end if      
    end if;
  end process;
  process(38400bps)
  begin
    if(rising_edge(38400bps)) then
      19200bps <= not 19200bps; 
    end if;
  end process;
  process(19200bps)
  begin
    if(rising_edge(19200bps)) then
      9600bps <= not 9600bps; 
    end if;
  end process; 
  process(9600bps)
  begin
    if(rising_edge(9600bps)) then
      4800bps <= not 4800bps; 
    end if;
  end process; 
  process(4800bps)
  begin
    if(rising_edge(4800bps)) then
      2400bps <= not 2400bps; 
    end if;
  end process;  
  process(2400bps)
  begin
    if(rising_edge(2400bps)) then
      1200bps <= not 1200bps; 
    end if;
  end process; 
  process(1200bps)
  begin
    if(rising_edge(1200bps)) then
      600bps <= not 600bps; 
    end if;
  end process;  
  process(600bps)
  begin
    if(rising_edge(600bps)) then
      300bps <= not 300bps; 
      110bps <= not 110bps;
    end if;
  end process;       
  clk_out <= 460800bps when baud_rate_gen = "1001"
             230400bps when baud_rate_gen = "1000"
             115200bps when baud_rate_gen = "0111"
              38400bps when baud_rate_gen = "0110"
              19200bps when baud_rate_gen = "0101"
               9600bps when baud_rate_gen = "0100"
               2400bps when baud_rate_gen = "0011"
               1200bps when baud_rate_gen = "0010"
                300bps when baud_rate_gen = "0001"
                110bps when baud_rate_gen = "0000";
end Behavioral;