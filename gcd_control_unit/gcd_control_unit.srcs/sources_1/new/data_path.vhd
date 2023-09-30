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
        clock, reset, x_we, y_we: in std_logic;
        x_in, y_in : in std_logic_vector(7 downto 0);
        x_selector, y_selector : in std_logic;
        flags : out std_logic_vector(2 downto 0); -- L E G
        gcd : out std_logic_vector(7 downto 0)
    );
end data_path;

architecture Behavioral of data_path is
    signal rx, ry, rx_in, ry_in, sub_x, sub_y: std_logic_vector(7 downto 0);
    signal comp : std_logic_vector(2 downto 0);
begin
    U0: entity work.comparator port map(a => rx, b => ry, less => flags(2), equal => flags(1), greater => flags(0));
    U1: entity work.register_8bit port map(clock => clock, reset => reset, we => x_we, data_in => rx_in, data_out => rx);
    U2: entity work.register_8bit port map(clock => clock, reset => reset, we => y_we, data_in => ry_in, data_out => ry);
    U3: entity work.subtractor port map(a => rx, b => ry, r => sub_x);
    U4: entity work.subtractor port map(a => ry, b => rx, r => sub_y);
    rx_in <= x_in when x_selector = '1' else sub_x;
    ry_in <= y_in when y_selector = '1' else sub_y;
    gcd <= rx;
end Behavioral;
