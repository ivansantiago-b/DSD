----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/01/2023 11:12:34 PM
-- Design Name: 
-- Module Name: ram - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity ram is
    port(
        clock, we: in std_logic;
        address : in std_logic_vector(7 downto 0);
        data_in : in std_logic_vector(6 downto 0);
        data_out : out std_logic_vector(6 downto 0)
    );
end ram;

architecture Behavioral of ram is
    type ram_t is array(255 downto 0) of std_logic_vector(6 downto 0);
    signal ram_data : ram_t;
begin
    process(clock, we)
    begin
        if rising_edge(clock) then
            if we = '1' then
                ram_data(to_integer(unsigned(address))) <= data_in;
            end if;
        end if;
    end process;
    data_out <= ram_data(to_integer(unsigned(address)));
end Behavioral;
