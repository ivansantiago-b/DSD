----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/26/2023 08:51:02 PM
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    port(
        clock, reset, go : in std_logic;
        comp_n, comp_i : in std_logic;
        wa_sel, i_sel, y_sel, ri_sel : out std_logic;
        ra_sel : out std_logic_vector(1 downto 0);
        n_we, i_we, x_we, y_we, t_we, ram_we : out std_logic;
        i_ext, r: out std_logic_vector(7 downto 0)
    );
end control_unit;

architecture Behavioral of control_unit is
    type state_t is (start, input, a1, a2, test_n, pop_x, pop_y, pop_z, push, test_i, done);
    signal current_state, next_state : state_t;
begin
state_register:
    process(clock, reset)
    begin
        if reset = '1' then
            current_state <= start;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
    end process state_register;
    
machine_input:
    process(current_state, go, comp_n, comp_i)
    begin
        case current_state is
            when start =>
                if go = '1' then
                    next_state <= input;
                else
                    next_state <= start;
                end if;
            when input =>
                next_state <= a1;
            when a1 =>
                next_state <= a2;
            when a2 =>
                next_state <= test_n;
            when test_n =>
                if comp_n = '1' then
                    next_state <= done;
                else
                    next_state <= pop_x;
                end if;
            when pop_x =>
                next_state <= pop_y;
            when pop_y =>
                next_state <= pop_z;
            when pop_z =>
                next_state <= push;
            when push =>
                next_state <= test_i;
            when test_i =>
                if comp_i = '1' then
                    next_state <= done;
                else
                    next_state <= pop_x;
                end if;
            when done =>
                next_state <= done;
            when others =>
                null;
        end case;
    end process;

machine_output:
    process(current_state)
    begin
        case current_state is                                   
            when start =>                                       
                t_we <= '0';                                    
                n_we <= '0';                                    
                i_we <= '0';                                    
                x_we <= '0';                                    
                y_we <= '0';                                    
                ram_we <= '0';                                  
                i_sel <= '1';                                   
                y_sel <= '0';                                   
                wa_sel <= '0';                                  
                ra_sel <= "00";                                 
                ri_sel <= '1';                                  
                r <= x"00";                                     
                i_ext <= x"00";                                 
            when input =>                                       
                i_sel <= '1';   -- Select extern i              
                i_we <= '1';    -- Write i register             
                ri_sel <= '1';  -- Select extern ram input      
                wa_sel <= '0';  -- Select i as write address    
                i_ext <= x"00"; -- a(0) = 0                     
                r <= x"00";                                     
                ram_we <= '1';  -- Write RAM                    
                n_we <= '1';    -- Write n register             
            when a1 =>                                          
                n_we <= '0';                                    
                ram_we <= '0';                                  
                i_ext <= x"01"; -- a(1) = 1                     
                r <= x"01";                                     
            when a2 =>                                          
                ram_we <= '1';                                  
                i_ext <= x"02"; -- a(2) = 2                     
            when pop_x =>                                       
                i_we <= '0';                                    
                ram_we <= '0';                                  
                ra_sel <= "00"; -- Select i as read address     
                x_we <= '1';                                    
            when pop_y =>                                       
                x_we <= '0';                                    
                ra_sel <= "01"; -- Select x as read address     
                y_sel <= '1';   -- Select RAM out as y input    
                y_we <= '1';                                    
                i_sel <= '0';   -- Increment i                  
                i_we <= '1';                                    
            when pop_z =>                                       
                i_we <= '0';                                    
                ra_sel <= "11"; -- Select i - x as read address 
                y_sel <= '0';   -- Select z as y input;         
                y_we <= '1';                                    
            when push =>                                        
                y_we <= '0';                                    
                ri_sel <= '0';  -- Select y as ram input        
                wa_sel <= '0';  -- Select i as write address    
                ram_we <= '1';                                  
            when test_i =>                                      
                ram_we <= '0';                                  
            when done =>                                        
                ra_sel <= "10"; -- Select n as read address     
                t_we <= '1';    -- write t a(n)                 
            when others =>                                      
                null;                                           
        end case;
    end process machine_output;
end Behavioral;
