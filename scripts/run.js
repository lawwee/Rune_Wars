const main = async () => {
    const [ owner, randomUser, another ] = await hre.ethers.getSigners();
    const ownerContractFactory = await hre.ethers.getContractFactory("RuneAttack")
    const ownerContract = await ownerContractFactory.deploy()
    await ownerContract.deployed()

    console.log("ownership Contract address is :", ownerContract.address);

    // let txn = await ownerContract._npcCharacter("Blessing", 9867);
    // await txn.wait()

    // let txn = await ownerContract.createNPC(0);
    // await txn.wait()

    let txn = await ownerContract.createCharacter("Lawwee");
    await txn.wait();
    console.log("Address of owner is:", owner.address);

    txn = await ownerContract.connect(randomUser).createCharacter("Biggie");
    await txn.wait();
    console.log("Address of random user is:", randomUser.address);

    txn = await ownerContract.lagertha();
    await txn.wait()

    // txn = await ownerContract.another();
    // await txn.wait()

    txn = await ownerContract.fightNPC("Lawwee", "Lagertha");
    await txn.wait()
    // txn = await ownerContract.connect(randomUser).fightNPC("Biggie", "Blessing");
    // await txn.wait()

    // txn = await ownerContract.fightPlayer("Lawwee", "Biggie");
    // await txn.wait()

    // txn = await ownerContract._fight(0,1);
    // await txn.wait()

    // txn = await ownerContract._fight(0, 1);
    // await txn.wait()

    // txn = await ownerContract.connect(another).createRandomPlayer("Dearie");
    // await txn.wait();
    // console.log("Address of another user is:", another.address);

    // // txn = await ownerContract.balanceOf(owner.address);
    // // await txn.wait();

    // txn = await ownerContract.ownerOf(1);

    // txn = await ownerContract.connect(randomUser).transferFrom(randomUser.address, another.address, 1);
    // await txn.wait();

    // txn = await ownerContract.connect(randomUser).createRandomPlayer("Biggie")
    // await txn.wait();

    // txn = await ownerContract._fight(0, 1)
    // await txn.wait();

    // txn = await ownerContract._fight(0, 1)
    // await txn.wait();

}

const runMain = async () => {
    try {
        await main()
        process.exit(0)
    } catch (error) {
        console.log(error);
        process.exit(1)
    }
}

runMain();