----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2023 01:06:52 PM
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity data_path is
    port(
        a_selector : in std_logic_vector(2 downto 0);
        a : in std_logic_vector(7 downto 0);
        clock, reset, i_selector, y_selector, r_selector : in std_logic;
        ram_we, n_we, x_we, y_we, i_we, t_we: in std_logic;
        n_in : in std_logic_vector(7 downto 0);
        r_in : in std_logic_vector(6 downto 0);
        n_comp, i_comp : out std_logic;
        t : out std_logic_vector(7 downto 0)
    );
end data_path;

architecture Behavioral of data_path is
    signal ram_out, ram_in : std_logic_vector(6 downto 0);
    signal address, n, i, i_in, x, y, y_in, t_in, n_minus_x, x_plus_y, inc_i: std_logic_vector(7 downto 0);
begin
U0:
    entity work.ram port map(clock => clock, we => ram_we, address => address, data_in => ram_in, data_out => ram_out);
U1: 
    entity work.register_8bit port map(reset => reset, we => n_we, data_in => n_in, data_out => n);
U2:
    entity work.register_8bit port map(reset => reset, we => i_we, data_in => i_in, data_out => i);
U3:
    entity work.register_8bit port map(reset => reset, we => x_we, data_in => t_in, data_out => x);
U4:
    entity work.register_8bit port map(reset => reset, we => y_we, data_in => y_in, data_out => y);
U5:
    entity work.register_8bit port map(reset => reset, we => t_we, data_in => t_in, data_out => t);
comparator_n:
    n_comp <= '1' when n < 3 else '0';
comparator_i:
    i_comp <= '1' when i = n else '0';
subtractor:
    n_minus_x <= n - x;
adder:
    x_plus_y <= t_in + y;
icrement_i:
    inc_i <= i + 1;
address_multiplexer:
    with a_selector select
        address <= n when "000",
                   i when "001",
                   x when "010",
                   n_minus_x when "011",
                   a when others;
i_multiplexer:
    i_in <= x"02" when i_selector = '0' else inc_i;
y_multiplexer:
    y_in <= t_in when y_selector = '0' else x_plus_y;
    t_in <= '0' & ram_out;
ram_in_multiplexer:
    ram_in <= y(6 downto 0) when r_selector = '1' else r_in;
end Behavioral;
