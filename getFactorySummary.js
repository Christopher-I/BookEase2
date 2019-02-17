import web3 from './web3';
import betContract from './build/BetContract.json';
import factory from '../ethereum/factory';


export default async() =>{

  let entireSummary = [];
  
  const deployedContractsLength = await factory.methods.getDeployedContractsLength().call();
  let summary = await factory.methods.deployedContracts(0).call();
  console.log(summary);

//because solidity does not return the entire array, have to call each value and store it
  for (i = 0; i < deployedContractsLength; i++) {
    let summary = await factory.methods.deployedContracts(i).call();
    entireSummary.push(summary);
}
console.log(entireSummary);
  return entireSummary;

};
