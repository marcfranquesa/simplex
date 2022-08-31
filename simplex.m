function [] = ASP()
    [length_c, length_b, c, A, b] = read_data("Data/P13_4.txt");

    iteration = 0;
    BLAND = false;
    
    if BLAND
        fprintf('Starting simplex with Bland rule.\n');
    else
        fprintf('Starting simplex without Bland rule.\n');
    end

    % Phase I
    fprintf('Phase I \n');
    c_I = [zeros(1, length_c) ones(1, length_b)];
    VNB_I = [1 : length_c];
    VB_I = [length_c + 1 : length_c + length_b];
    A_I = [A, eye(length_b)];
    invB_I = eye(length_b);
    xb_I = b;

    [xb, VB, VNB, invB, type, iteration] = phase(xb_I, c_I, A_I, invB_I, VB_I, VNB_I, BLAND, iteration);

    fprintf('   Iteration %3d : ', iteration);

    % Phase II
    if c_I(VB) * xb == 0
        fprintf('Basic feasible solution found. Proceding to phase II.\n');
        fprintf('Phase II \n');
        VNB = VNB(VNB <= length_c);
        [xb, VB, VNB, invB, type, iteration] = phase(xb, c, A, invB, VB, VNB, BLAND, iteration);
        
        % Displaying the solution
        fprintf('   Iteration %3d : ', iteration)
        if type == 1
            fprintf('Optimal solution found.\nEnd of ASP.\n');
            fprintf('VB* =\n'); disp(VB); 
            fprintf('xb* =\n'); disp(xb');
            fprintf('VNB* =\n'); disp(VNB);
            fprintf('r* =\n'); disp(c(VNB) - c(VB) * invB * A(:, VNB));
            fprintf('z* =\n'); disp(c(VB) * xb);
        else
            fprintf('Unlimited problem.\nEnd of ASP.\n');
        end
    
    % If no valid solution was found in phase I
    else
        fprintf('Basic feasible solution not found. Will not be proceeding to phase II.\n');
        fprintf('   Unfeasible problem.\n')
        fprintf('End of ASP.\n');
    
    end
    

end

function [length_c, length_b, c, A, b] = read_data(filename)
    % Each exercise has its own file, where the length of the c vector
    % and the length of b vector are indicated to facilitate the reading 
    fileID = fopen(filename, 'r');
    
    formatSpec = '%d %f';

    % We will first be reading the lengths
    length_c = fscanf(fileID, formatSpec, 1);
    length_b = fscanf(fileID, formatSpec, 1);

    % We will now read c, A and b
    c = fscanf(fileID, formatSpec, [1 length_c]);
    A = fscanf(fileID, formatSpec, [length_c length_b])';
    b = fscanf(fileID, formatSpec, [length_b 1]);
end

function [xb, VB, VNB, invB, type, iteration] = phase(xb, c, A, invB, VB, VNB, BLAND, iteration)
    % Type will be 0 if we continue, 1 if we have found a solution and -1
    % if the problem is unlimited
    type = 0;
    while type == 0
        [xb, invB, VB, VNB, type, iteration] = simplex_iteration(xb, c, A, invB, VB, VNB, type, BLAND, iteration);
    end
    
end


function [xb, invB, VB, VNB, type, iteration] = simplex_iteration(xb, c, A, invB, VB, VNB, type, BLAND, iteration)
    iteration = iteration + 1;
    ZERO = -1e-8;

    r = c(VNB) - c(VB) * invB * A(:, VNB);
    
    % Checking if all values are greater than 0, if so an optimal solution
    % has been found
    if all(r >= ZERO)
        type = 1;
        return;
    end
    
    % Bland rule
    if (BLAND)
        in = find(r < ZERO);
        q = min(VNB(in));
    else
        in = find(r == min(r));
        q = VNB(in(1));
    end
    
    
    
    % Calculating the direction to move to the variable q
    db = -invB * A(:, q);


    % Checking if db is unlimited
    if all(db >= ZERO)
        type = -1;
        return;
    end

    % Figuring out the position of the basic variable that goes out
    neg_pos = find(db < ZERO);
    neg_xb = xb(neg_pos);
    [theta position_out_neg_xb] = min(-neg_xb./db(neg_pos));
    position_out_xb = find(xb == neg_xb(position_out_neg_xb));
    
    % Updating the variables
    xb = xb + theta * db;
    xb(position_out_xb) = theta;

    if BLAND
        p = min(VB(position_out_xb));
    else
        p = VB(position_out_xb(1));
    end

    rq = r(VNB == q);

    % Updating VB and VNB
    VB(position_out_xb) = q;
    VNB(VNB == q) = p;

    % Updating invB
    H = eye(length(invB));
    H(:, position_out_xb) = -db/db(position_out_xb);
    H(position_out_xb, position_out_xb) = -1/db(position_out_xb);
    invB = H * invB;

    fprintf('   Iteration %3d : q = %2d, rq = %9.3f B(p) = %2d, theta* = %9.3f, z = %9.3f\n', [iteration q rq p theta (c(VB) * xb)]);
end



