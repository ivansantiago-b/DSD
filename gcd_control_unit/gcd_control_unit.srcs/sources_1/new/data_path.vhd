----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2023 02:32:39 PM
-- Design Name: 
-- Module Name: data_path - Behavioral
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

entity data_path is
    port(
        clock, reset : in std_logic;
        x_in, y_in : in std_logic_vector(7 downto 0);
        x_sel, y_sel, x_we, y_we, gcd_we : in std_logic;
        flags : out std_logic_vector(2 downto 0);
        gcd : out std_logic_vector(7 downto 0)
    );
end data_path;

architecture Behavioral of data_path is
    signal rx, ry, sub_x, sub_y, x, y: std_logic_vector(7 downto 0);
begin
U0:
    entity work.register_8bit port map(reset => reset, we => x_we, data_in => x, data_out => rx);
U1:
    entity work.register_8bit port map(reset => reset, we => y_we, data_in => y, data_out => ry);
U3:
    entity work.register_8bit port map(reset => reset, we => gcd_we, data_in => rx, data_out => gcd);
U4:
    entity work.comparator port map(a => rx, b => ry, less => flags(2), equal => flags(1), greater => flags(0));
U5:
    entity work.subtractor port map(a => rx, b => ry, r => sub_x);
U6:
    entity work.subtractor port map(a => ry, b => rx, r => sub_y);
with x_sel select
    x <= x_in when '1', sub_x when others;
with y_sel select
    y <= y_in when '1', sub_y when others;
end Behavioral;
