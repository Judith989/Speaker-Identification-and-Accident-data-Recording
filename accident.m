classdef Vehicle
    properties
        id
        speed
        isSpeaker
        vote
    end
    
    methods
        function obj = Vehicle(id)
            obj.id = id;
            obj.speed = randi(80);
            obj.isSpeaker = false;
            obj.vote = false;
        end
    end
end

blockchain = struct('index', {}, 'data', {}, 'timestamp', {}, 'previousHash', {}, 'hash', {});
speedThreshold = 50;

numVehicles = 10;
vehicles = cell(numVehicles, 1);
for i = 1:numVehicles
    vehicles{i} = Vehicle(i);
end

numSimulations = 100;
for sim = 1:numSimulations
    accidentVehicles = randperm(numVehicles, 2);
    for i = accidentVehicles
        vehicles{i}.isSpeaker = true;
    end
    
    for i = 1:numVehicles
        if vehicles{i}.isSpeaker
            vehicles{i}.vote = vehicles{i}.speed > speedThreshold;
        end
    end
    
    votingData = struct('speakerID', accidentVehicles, 'votes', {vehicles{accidentVehicles}.vote});
    blockchain = addBlockToBlockchain(blockchain, votingData);
    
    % Reset for next simulation
    for i = 1:numVehicles
        vehicles{i}.isSpeaker = false;
        vehicles{i}.vote = false;
    end
end

% Analyze blockchain for majority votes and accident causes
% (Implement your analysis logic here)

% Plotting results
% Create plots to visualize accident causes, voting results, etc.
% (Implement your plotting logic here)

function newBlockchain = addBlockToBlockchain(blockchain, data)
    newBlock.index = numel(blockchain) + 1;
    newBlock.data = data;
    newBlock.timestamp = datetime('now');
    
    if isempty(blockchain)
        newBlock.previousHash = 'genesis';
    else
        newBlock.previousHash = blockchain(end).hash;
    end
    
    newBlock.hash = calculateHash(newBlock);
    
    newBlockchain = [blockchain; newBlock];
end

function hash = calculateHash(block)
    data = struct2json(block);
    hash = num2str(sum(uint8(data)));
end

function json = struct2json(data)
    json = jsonencode(data);
end
