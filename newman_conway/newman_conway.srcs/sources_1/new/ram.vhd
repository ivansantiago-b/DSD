----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 03:40:03 PM
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
use IEEE.NUMERIC_STD.ALL;

entity ram is
    generic(
        address_width : integer := 8;
        data_width : integer := 8
    );
    port(
        clock, we : in std_logic;
        read_address, write_address : in std_logic_vector(address_width - 1 downto 0);
        d : in std_logic_vector(data_width - 1 downto 0);
        q : out std_logic_vector(data_width - 1 downto 0)
    );
end ram;

architecture Behavioral of ram is
    type ram_t is array(0 to (2 ** address_width) - 1) of std_logic_vector(data_width - 1 downto 0);
    signal data : ram_t;
begin
    process(clock, we)
    begin
        if (rising_edge(clock) and we = '1') then
            data(to_integer(unsigned(write_address))) <= d;
        end if;
        q <= data(to_integer(unsigned(read_address)));
    end process;
end Behavioral;
