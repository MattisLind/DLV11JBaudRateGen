library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity baudrategen is
port (
   clk_in: in std_logic; -- clock input on FPGA
   clk_out1: out std_logic; -- clock output 
   clk_out2: out std_logic; -- clock output 
   clk_out3: out std_logic; -- clock output 
   clk_out4: out std_logic; -- clock output          
   chan1_baud_rate_sel: in std_logic_vector(3 downto 0);
   chan2_baud_rate_sel: in std_logic_vector(3 downto 0);
   chan3_baud_rate_sel: in std_logic_vector(3 downto 0);
   chan4_baud_rate_sel: in std_logic_vector(3 downto 0)
  );
end baudrategen;

architecture Behavioral of baudrategen is
signal divisor: std_logic_vector(27 downto 0):=(others =>'0');
signal r460800bps, r230400bps, r115200bps, r38400bps, r19200bps, r9600bps, r4800bps, r2400bps, r1200bps, r600bps,  r300bps, r110bps: std_logic;
signal divide_by_three: std_logic_vector(1 downto 0):=(others=>'0');
begin
  r460800bps <= clk_in;
  process(clk_in)
  begin
    if(rising_edge(clk_in)) then
      r230400bps <= not r230400bps; 
    end if;
  end process;
  process(r230400bps)
  begin
    if(rising_edge(r230400bps)) then
      r115200bps <= not r115200bps; 
    end if;
  end process;
  process(r115200bps)
  begin
    if(rising_edge(r230400bps)) then
      if divide_by_three = "00" then
        divide_by_three <= "01";
        r38400bps <= not r38400bps;
      end if;
      if divide_by_three = "01" then
        divide_by_three <= "10";
      end if;     
      if divide_by_three = "10" then
        divide_by_three <= "00";
      end if;     
    end if;
  end process;
  process(r38400bps)
  begin
    if(rising_edge(r38400bps)) then
      r19200bps <= not r19200bps; 
    end if;
  end process;
  process(r19200bps)
  begin
    if(rising_edge(r19200bps)) then
      r9600bps <= not r9600bps; 
    end if;
  end process; 
  process(r9600bps)
  begin
    if(rising_edge(r9600bps)) then
      r4800bps <= not r4800bps; 
    end if;
  end process; 
  process(r4800bps)
  begin
    if(rising_edge(r4800bps)) then
      r2400bps <= not r2400bps; 
    end if;
  end process;  
  process(r2400bps)
  begin
    if(rising_edge(r2400bps)) then
      r1200bps <= not r1200bps; 
    end if;
  end process; 
  process(r1200bps)
  begin
    if(rising_edge(r1200bps)) then
      r600bps <= not r600bps; 
    end if;
  end process;  
  process(r600bps)
  begin
    if(rising_edge(r600bps)) then
      r300bps <= not r300bps; 
      r110bps <= not r110bps;
    end if;
  end process; 
  WITH chan1_baud_rate_sel SELECT
  clk_out1 <= r460800bps WHEN "1001",
             r230400bps WHEN "1000",
             r115200bps WHEN "0111",
              r38400bps WHEN "0110",
              r19200bps WHEN "0101",
               r9600bps WHEN "0100",
               r2400bps WHEN "0011",
               r1200bps WHEN "0010",
                r300bps WHEN "0001",
                r110bps WHEN "0000",
             r230400bps WHEN OTHERS; 
  WITH chan2_baud_rate_sel SELECT
  clk_out2 <= r460800bps WHEN "1001",
             r230400bps WHEN "1000",
             r115200bps WHEN "0111",
              r38400bps WHEN "0110",
              r19200bps WHEN "0101",
               r9600bps WHEN "0100",
               r2400bps WHEN "0011",
               r1200bps WHEN "0010",
                r300bps WHEN "0001",
                r110bps WHEN "0000",
            r230400bps WHEN OTHERS;                 
  WITH chan3_baud_rate_sel SELECT
  clk_out3 <= r460800bps WHEN "1001",
             r230400bps WHEN "1000",
             r115200bps WHEN "0111",
              r38400bps WHEN "0110",
              r19200bps WHEN "0101",
               r9600bps WHEN "0100",
               r2400bps WHEN "0011",
               r1200bps WHEN "0010",
                r300bps WHEN "0001",
                r110bps WHEN "0000",
              r230400bps WHEN OTHERS; 
  WITH chan4_baud_rate_sel SELECT
  clk_out4 <= r460800bps WHEN "1001",
             r230400bps WHEN "1000",
             r115200bps WHEN "0111",
              r38400bps WHEN "0110",
              r19200bps WHEN "0101",
               r9600bps WHEN "0100",
               r2400bps WHEN "0011",
               r1200bps WHEN "0010",
                r300bps WHEN "0001",
                r110bps WHEN "0000",
            r230400bps WHEN OTHERS;  
end Behavioral;