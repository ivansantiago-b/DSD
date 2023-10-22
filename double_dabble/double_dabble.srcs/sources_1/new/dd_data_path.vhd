----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2023 12:16:08 AM
-- Design Name: 
-- Module Name: dd_data_path - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dd_data_path is
    port(
        clock, clear, we, se, n_sel, bcd_we : in std_logic;
        n : in std_logic_vector(7 downto 0);
        flag : out std_logic;
        bcd : out std_logic_vector(11 downto 0)
    );
end dd_data_path;

architecture Behavioral of dd_data_path is
    signal i_in, i : std_logic_vector(3 downto 0);
    signal x, x_in : std_logic_vector(19 downto 0);
    signal c_in : std_logic;
begin
I_REG:
    entity work.reg generic map(4) port map(clock => clock, clear => clear, we => we, data_in => i_in, data_out => i);
    i_in <= i + 1;
X_REG:
    entity work.shift_reg generic map(20) port map(clock => clock, clear => clear, we => we, se => se, data_in => x_in, data_out => x);
    x_in(7 downto 0) <= n when n_sel = '1' else x(7 downto 0);
D0_DABBLE:
    entity work.dabble port map(input => x(11 downto 8), output => x_in(11 downto 8));
D1_DABBLE:
    entity work.dabble port map(input => x(15 downto 12), output => x_in(15 downto 12));
D2_DABBLE:
    entity work.dabble port map(input => x(19 downto 16), output => x_in(19 downto 16));
BCD_REG:
    entity work.reg generic map(12) port map(clock => clock, clear => clear, we => bcd_we, data_in => x(19 downto 8), data_out => bcd);
    
    flag  <= '1' when i = "1000" else '0';
end Behavioral;
